var fs = require('fs'),
    path = require('path'),
    cheerio = require('cheerio'),
    parseCSS = require('css-rules');

// EXPORTS: INLINE FILE
exports.inlineFile = function(inFile, outFile, param1, param2) {
    var options = {},
        callback = null;
    
    if(param1) {
        if(typeof param1 === 'object')
            options = param1;
        else if(typeof param1 === 'function')
            callback = param1;
    }
    
    if(param2) {
        if(typeof param2 === 'function' && callback === null) {
            callback = param2;
        } else {
            throw 'Error: Invalid param';  
        }
    }
    
    if(callback === null) {
        throw 'Error: No callback function specified';     
    }

    makeDirectoryRecursive(path.dirname(outFile), function() {
       options.cssRoot = inFile.substring(0,inFile.lastIndexOf(getPathSeparator(inFile))+1);

        fs.readFile(inFile, 'utf8', function(err, html) {
           inline(html, options, function(inlineHtml) {
                // Write to file
                fs.writeFile(outFile, inlineHtml, 'utf8', function() {
                    return callback();   
                }); 
            }); 
        });        
    });
};

// EXPORTS: INLINE HTML
exports.inlineHtml = function(html, param1, param2) {
    var options = {},
        callback = null;
    
    if(param1) {
        if(typeof param1 === 'object')
            options = param1;
        else if(typeof param1 === 'function')
            callback = param1;
    }
    
    if(param2) {
        if(typeof param2 === 'function' && callback === null) {
            callback = param2;
        } else {
            throw 'Error: Invalid param';
        }
    }
    
    if(callback === null) {
        throw 'Error: No callback function specified';  
    }
    
    inline(html, options, function(html) {
        return callback(html);
    });
    
};

// FUNCTION: inline
function inline(html, options, callback) {
    var settings = {
        cssRoot: '',
        removeAttributes: true
    };

	// Check options defaults
	options.decodeEntities = options.decodeEntities == false ?  false : true;
	options.inlineStyleTags = options.inlineStyleTags == false ?  false : true;

    for(var prop in settings) { if(typeof options[prop] !== 'undefined') settings[prop] = options[prop]; }

    $ = cheerio.load(html, { decodeEntities: options.decodeEntities });
    
    var stylesheets = [];

    $('link').each(function(i, elem) {
        // Ignore remote files
        if(elem.attribs.href.substring(0, 4) != 'http' && elem.attribs.href.substring(0, 3) != 'ftp')
            stylesheets.push(settings.cssRoot + elem.attribs.href);
            $(this).remove();
    });
    
    inlineStylesheetRecursive(stylesheets, function() {
        
        // Loop through embedded style tags
		if(options.inlineStyleTags) { 
			$('style').each(function(i, elem) {
				embedStyles($(this).text());
				$(this).remove();
			});
		}

        if(settings.removeAttributes == true) {
			$('*').each(function(i, elem) {
				// Remove class attributes
				if($(elem).attr('class') && $(elem).attr('class').indexOf('keepattr') < 0) {
					$(elem).removeAttr('class');
				}
				
				// Remove id attributes
				if($(elem).attr('id') && $(elem).attr('id').indexOf('keepattr') < 0) {
					$(elem).removeAttr('id');
				}
			});
        }

        return callback($.html());     
    });  
}

// FUNCTION: inlineStylesheetRecursive
// Loop through external stylesheets
function inlineStylesheetRecursive(stylesheets, callback) {
    if(stylesheets.length > 0) {
		fs.access(stylesheets[0], function(err) {
			if(!err) {
				fs.readFile(stylesheets[0], 'utf8', function(err, css) {
					embedStyles(css);
					stylesheets.shift();
					inlineStylesheetRecursive(stylesheets, callback);
				}); 
			} else {
				console.log('Error: ENOENT, could not access stylesheet %s', err.path);
				return callback(false);
			}
		});		
    } else {
        return callback();   
    }
}

// FUNCTION: makeDirectoryRecursive
function makeDirectoryRecursive(dirPath, callback) {
    fs.access(dirPath, function(err) {
        if(err) {
            fs.mkdir(dirPath, function(err) {
                if (err && err.code == 'ENOENT') {
                      makeDirectoryRecursive(path.dirname(dirPath));
                      makeDirectoryRecursive(dirPath, callback);
                } else {
                    if(callback) 
						return callback();
                }
            });
        } else {
            if(callback) 
				return callback();
        }
    });  
}

// FUNCTION: getPathSeparator
function getPathSeparator(path) {
    if(path.indexOf('\\') > -1)
        return '\\';
    else
        return '/';   
};

// FUNCTION: embedStyles
function embedStyles(css) {
    parseCSS(css).forEach(function (rule) {
        var selector = rule[0];
            data = rule[1],
            style = '';

        // Not a pseudo-class
        if(!/\:.*/i.test(selector)) {
            var $elem = $(selector);

            if(typeof $elem.attr('style') !== 'undefined') {
                style = $elem.attr('style').trim();

                if(style.charAt(style.length - 1) != ';')
                    style += ';';
            }

			// Loop through new rules
            for(var i=0; i<data.length; i++) {
				var currentStyle = style.split(';');
				for(var j in currentStyle) {
					var styleSplit = currentStyle[j].split(':');
					
					// Remove old style
					if(styleSplit[0] && data[i].toLowerCase().trim() == styleSplit[0].toLowerCase().trim()) {
						style = style.replace(currentStyle[j] + ';', '');
					}
				}
				
				style += ' ' + data[i] + ':' + data[data[i]] + ';';
			}

            $elem.attr('style', style.trim());
        }
    });
}
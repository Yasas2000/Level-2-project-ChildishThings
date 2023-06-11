var inlineCSS = require('../index'),
	fs = require('fs');
	
var inFile = 'test/html/in.html',
	outFile = 'test/html/content/generated/out.html';

	inlineCSS.inlineFile(inFile, outFile, { decodeEntities: false }, function() {
		console.log('Test: Inlining file');
		console.log('----------------------------------');
		console.log('File: ' + inFile + '\n');
		console.log('Generated file `' + outFile + '`\n\n');
	});

var html = '<style>\n\tp { height: 50px; } \n\t.info { font-weight: bold; }\n</style>\n<p class="info">This is a paragraph</p>';

	inlineCSS.inlineHtml(html, function(inlineHtml) {
		console.log('Test: Inlining html' );
		console.log('----------------------------------');
		console.log('Html:\n' + html + '\n');
		console.log('Generated:' + inlineHtml + '\n\n');
	});
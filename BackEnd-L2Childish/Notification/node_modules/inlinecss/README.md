# inlineCSS

A [NodeJS](http://nodejs.org/) package for inlining external stylesheets and embedded style tags into html content.

## Install

`npm install inlinecss`

## Usage
	var inlineCSS = require('inlinecss');
	var html = inlineCSS.inlineHtml('<style>p{height:50px;}</style><p>Text</p>');

## Methods

### inlineHtml(html[, options], callback)

Inlines raw html content

- `html` - Raw html
- `options` - See Options below
- `callback` - Function

		inlineCSS.inlineHtml(html, function(inlineHtml) {
			console.log(inlineHtml);
		});

Returns `inlined html` as an argument.

### inlineFile(inFile, outFile[, options], callback)

Creates an inlined html file

- `inFile` - Location of file to be inlined
- `outFile` - Destination of generated file
- `options` - See Options below
- `callback` - Function

		inlineCSS.inlineFile(inFile, outFile, function() {
			console.log('success');
		});

No return arguments.

## Options

#### options.cssRoot
Define an optional base directory for external stylesheets

Type: `String`  
Default: `''`

#### options.decodeEntities
Decode HTML entities. Eg: `& -> &amp;`

Type: `Boolean`  
Default: `true`

#### options.inlineStyleTags
Inline content in `<style>` tags found in the HTML document

Type: `Boolean`  
Default: `true`

#### options.removeAttributes
Remove `class` and `id` attributes  
Provide `keepattr` in the attribute value to prevent an attribute from being removed.

Type: `Boolean`  
Default: `true`

## Dependencies
- [cheerio](https://github.com/cheeriojs/cheerio)
- [css-rules](https://github.com/jonkemp/css-rules)

## License

MIT © Rɪpəl Labs

var { Readability } = require('@mozilla/readability');
var { JSDOM } = require('jsdom');
var article = null;

console.log(Bun.argv[2]);
if (Bun.argv[2] == null) {
	console.log("Please provide a url to parse");
	process.exit(1);
}
const url = Bun.argv[2];
const html = await fetch(url).then((res) => res.text());

var doc = new JSDOM(html, { url });
const reader = new Readability(doc.window.document);
const parsedPage = reader.parse();
if (parsedPage == null) {
	console.log("Error parsing page");
	process.exit(1);
}
console.log(parsedPage.textContent);

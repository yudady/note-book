const requestify = require('requestify');
const cheerio = require('cheerio')

const url = 'https://93418ymx.500ei.com/';

// GET Request:
requestify.get(url).then(function (response) {
    //console.log(response);
}).fail(function (response) {
    const $ = cheerio.load(response.body);
    let script = $('script').toString();
    console.log(script);
});
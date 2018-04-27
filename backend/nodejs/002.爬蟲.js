/**
 * Request - Simplified HTTP client
 * 
 * https://www.npmjs.com/package/request
 */
const request = require('request')

/**
 * 這個也很酷
 * http://ranm8.github.io/requestify/
 */
const requestify = require('requestify');

/**
 * 链式調用
 * const superagent = require('superagent');
 * 很多plugin
 * https://github.com/visionmedia/superagent
 */



/**
 * Fast, flexible & lean implementation of core jQuery designed specifically for the server.
 * 用 cheerio 擷取我們要的部份
 * 
 * https://www.npmjs.com/package/cheerio
 */
const cheerio = require('cheerio')

const url = 'http://www.cwb.gov.tw/V7/forecast/taiwan/Taipei_City.htm'


let options = {
    headers: {
        'User-Agent': 'request'
    }
};

function callback(err, res, body) {
    if (!err && res.statusCode == 200) {
        // http header
        const headers = JSON.stringify(res.headers);
        console.log(headers);

        // 把 body 放進 cheerio 準備分析
        const $ = cheerio.load(body)
        let weathers = [];
        $('#box8 .FcstBoxTable01 tbody tr').each(function (i, elem) {
            weathers.push($(this).text().split('\n'))
        });

        weathers = weathers.map(weather => ({
            time: weather[1].substring(2).split(' ')[0],
            temp: weather[2].substring(2),
            rain: weather[6].substring(2),
        }))

        console.log(weathers)
    }
}

request(url, options, callback);




// GET Request:
requestify.get('http://example.com').then(function (response) {
    //  Get the response body (JSON parsed - JSON response or jQuery object in case of XML response)
    //  console.log(response.getBody().length);
    //  console.log(response.getHeaders());
    //  Get the response raw body
    console.log(JSON.stringify(response.code));
    //;
});


//  POST Request in JSON:
requestify.post('http://example.com', {
    hello: 'world'
})
    .then(function (response) {
        //  Get the response body
        //  console.log(response.getBody().length);
    });



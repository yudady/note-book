const http = require('http');
const { URL } = require('url');
let fs = require('fs');


console.log("------------------------");


console.log('hello world');
let date = new Date();
console.log(date.getFullYear());

const myURL = new URL('https://example.org/foo#bar');
console.log(myURL.hash);


console.log("1------------------------");
// 異步讀取文件
fs.readFile('C:/setup.log', (err, date) => {
    if (err) {
        console.log('read fail ！！！');
    } else {
        console.log(date.toString());
    }
});
console.log("2------------------------");

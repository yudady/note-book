js 
ctrl + shift + p
quokka.js start on current file

> npm install jsdom-quokka-plugin -g


------------------------------------------------
({
    plugins: 'jsdom-quokka-plugin',
    jsdom: {html: `<div id="test">Hello</div>`}
})

const testDiv = document.getElementById('test');

console.log(testDiv.innerHTML);


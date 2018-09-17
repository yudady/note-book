({
    plugins: 'jsdom-quokka-plugin',
    jsdom: { html: `<div id="test">Hello</div>` }
})
const testDiv = document.getElementById('test');

console.log(testDiv.innerHTML);


var obj1 = (function () {
    var args = Array.from(arguments);
    return args;
})(1, 2, 3);
console.log(obj1);


let obj2 = Array.from(new Set(["foo", "window"]));
console.log(obj2);


let map = new Map([[1, 2], [2, 4], [4, 8]]);
let obj3 = Array.from(map);
console.log(obj3);


let obj4 = Array.from([1, 2, 3, 4, 5, 6], x => x + x + x);
console.log(obj4);

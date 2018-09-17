/**
 * every :  陣列比對，所有元素都是 true 才是 true (很好用)
 */
var arr = ["jack", "john", "may", "su", "Ada"];

var flag = arr.every(function (value, index, array) {
    return value.length > 2;
});

console.log(flag);


var flag2 = arr.every(function (value, index, array) {
    return value.length > 3;
});

console.log(flag2);
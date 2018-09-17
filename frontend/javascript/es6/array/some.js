/**
 * some : 陣列比對，只要有一個元素是 true，就返回 true (很好用)
 */

var arr = ["jack", "john", "may", "su", "Ada"];

var flag = arr.some(function (value, index, array) {
    return value == "may" ? true : false;
});
console.log(flag);


var flag2 = arr.some(value => {
    return value == "may2" ? true : false;;
});
console.log(flag2);
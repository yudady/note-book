/**
 * filter : 陣列過濾，透過 filter 的過濾條件返回一個新陣列 (非常好用)
 */
var arr = ["jack", "john", "may", "su", "Ada"];

var arr2 = arr.filter(function (value) {
    return value.length > 3;
});

console.log(arr2);


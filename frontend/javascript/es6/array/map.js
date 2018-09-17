/**
 * map : 對陣列中的各元素進行操作，操作後的值會被寫入新的陣列中並返回
 */
var arr = [1, 2, 3, 4, 5, 6];

var arr2 = arr.map(x => {
    return x * x + 10000;
});

console.log(arr2);


var arr3 = arr.map((x, i) => {
    return x * x + i * 10000;
});

console.log(arr3);

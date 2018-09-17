/**
 * sort : 陣列排序 (很好用)
 */
let arr = [5, 9, 1, 3, 2, 6];
arr.sort();
console.log(arr);

arr.sort(function (a, b) {
    return a - b;
});
console.log(arr);


arr.sort(function (a, b) {
    return b - a;
});
console.log(arr);


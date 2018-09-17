/**
 * push : 新增元素或元素組到陣列 (想不用到都不行)
 */
var arr = {
    name: [],
    data: []
};

arr.name.push("jack");

arr.name.push("john");

arr.data.push({ weight: 60, height: 170 });

arr.data.push({ weight: 62, height: 175 });

let obj1 = JSON.stringify(arr);
console.log(obj1);
/**
 * splice : 改變陣列內容，移除或新增元素
 */


let obj1 = ["angel", "clown", "mandarin", "surgeon"];
console.log(obj1);

// 重第2個位置開始，去掉0個，在第2位加入"drum"
var removed = obj1.splice(2, 0, "drum");
console.log(obj1);

// 重第2個位置開始，去掉1個，在第2位加入"drumNew"
removed = obj1.splice(2, 1, "drumNew");
console.log(obj1);

// 重第2個位置開始，去掉1個
removed = obj1.splice(2, 1);
console.log(obj1);

// 重第0個位置開始，去掉2個，在第0位加入"parrot", "anemone", "blue"
removed = obj1.splice(0, 2, "parrot", "anemone", "blue");
console.log(obj1);

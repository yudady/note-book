let people = [{
        name: 'Casper',
        like: '鍋燒意麵',
        age: 18
    },
    {
        name: 'Wang',
        like: '炒麵',
        age: 24
    },
    {
        name: 'Bobo',
        like: '蘿蔔泥',
        age: 1
    },
    {
        name: '滷蛋',
        like: '蘿蔔泥',
        age: 3
    }
];


// Array.prototype.reduce()
let reduceEmpty = people.reduce(function (accumulator, currentValue, currentIndex, array) {});
// 沒有條件，會是 undefined
console.log(reduceEmpty);
let reducePlus = people.reduce(function (accumulator, currentValue, currentIndex, array) {
    // 分別為前一個回傳值, 目前值, 當前索引值
    console.log(accumulator, currentValue, currentIndex);
    return accumulator + currentValue.age; // 與前一個值相加
}, 0); // 傳入初始化值為 0
console.log(reducePlus); // 總和為 46


let reducePlus2 = people.reduce(function (accumulator, currentValue, currentIndex, array) {
    console.log('reduce', accumulator, currentValue, currentIndex)
    return Math.max(accumulator, currentValue.age); // 與前一個值比較哪個大
}, 0);
console.log(reducePlus2); // 最大值為 24

let reducePlus3 = people.reduce((sum, people) => {
    return sum + people.age;
});
console.log(reducePlus2);
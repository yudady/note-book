let [a, b, c] = [1, 2, 3];
console.log(a);
console.log(b);
console.log(c);

let set = new Set([1, 2, 2, 2, 1]);
console.log(set);

let obj = { a: 1 };
console.log(obj);


const map = new Map();
console.log(map);
map.set('a', 'abbbb');
console.log(map);

console.log(map);

const map2 = new Map([
    ['name', 'n'],
    ['age', 18],
    ['sex', 'man'],
]);

console.log(map2);


// 相同的陣列
let people = [
    {
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


// Array.prototype.filter()

let filterEmpty = people.filter(function (item, index, array) {
});
console.log(filterEmpty);    // 沒有條件，會是一個空陣列
let filterAgeThan5 = people.filter(function (item, index, array) {
    return item.age > 5;       // 取得大於五歲的
});
console.log(filterAgeThan5); // Casper, Wang 這兩個物件
let filterDouble = people.filter(function (item, index, array) {
    return index % 2 === 1;    // 取得陣列中雙數的物件
});
console.log(filterDouble);   // Wang, 滷蛋 這兩個物件

// Array.prototype.find()
let findEmpty = people.find(function (item, index, array) {
});
console.log(findEmpty);          // 沒有條件，會是 undefined
let findAgeThan5 = people.find(function (item, index, array) {
    return item.age > 5;           // 取得大於五歲的
});
console.log(findAgeThan5);       // 雖然答案有兩個，但只會回傳 Casper 這一個物件
let findLike = people.find(function (item, index, array) {
    return item.like === '蘿蔔泥';  // 取得陣列 like === '蘿蔔泥'
});
console.log(findLike);           // 雖然答案有兩個，但只會回傳第一個 Bobo 物件

// Array.prototype.forEach()
let forEachIt = people.forEach(function (item, index, array) {
    console.log(item, index, array); // 物件, 索引, 全部陣列
    return item;                     // forEach 沒在 return 的，所以這邊寫了也沒用
});
console.log(forEachIt);            // undefined
people.forEach(function (item, index, array) {
    item.age = item.age + 1;         // forEach 就如同 for，不過寫法更容易
});
console.log(people);               // 全部 age + 1

// Array.prototype.map()
let mapEmpty = people.map(function (item, index, array) {
});
console.log(mapEmpty);    // [undefined, undefined, undefined, undefined]
let mapAgeThan5 = people.map(function (item, index, array) {
    return item.age > 5;    // 比較大於五歲的
});
console.log(mapAgeThan5); // [true, true, false, false]
let mapAgeThan5_2 = people.map(function (item, index, array) {
    // 錯誤示範
    if (item.age > 5) {
        return item;              // 回傳大於五歲的
    }
    return false;               // 別以為空的或是 false 就不會回傳
});
console.log(mapAgeThan5_2);   // [{name: 'Casper'...}, {name: 'Wang'...}, false, false]
let mapEat = people.map(function (item, index, array) {
    if (item.like !== '蘿蔔泥') {
        return `${item.like} 好吃`;
    } else {
        return `${item.like} 不好吃`;
    }
});
console.log(mapEat);          // ["鍋燒意麵 好吃", "炒麵 好吃", "蘿蔔泥 不好吃", "蘿蔔泥 不好吃"]

// Array.prototype.every()
let array = [
    {
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
let ans = array.every(function (item, index, array) {
    // 物件, 索引, 全部陣列
    console.log(item, index, array); 
    // 當全部 age 大於 10 才能回傳 true
    return item.age > 10 
});
console.log(ans); // false: 只要有部分不符合，則為 false
let ans2 = array.every(function (item, index, array) {
    return item.age < 25
});
// true: 全部 age 都小於 25
console.log(ans2); 

// Array.prototype.some()
let ans3 = people.some(function (item, index, array) {
    // 當全部 age 大於 10 才能回傳 true
    return item.age > 10 
});
// true: 只要有部分符合，則為 true
console.log(ans3);  
let ans4 = people.some(function (item, index, array) {
    return item.age < 25
});
// true: 只要有部分符合，則為 true  
console.log(ans4); 
let ans5 = people.some(function (item, index, array) {
    return item.age > 25
});
// false: 全部都不符合則為 false
console.log(ans5); 















/**
 * Promise（代理對象，隊列），有3個狀態
 * 
 * 1. pending
 * 2. fulfilled
 * 3. rejected
 */


console.log('here we go');
let promiseA = new Promise(resolve => {
    setTimeout(() => {
        resolve('promiseA.resolve');
    }, 2000);
});
let promiseB = promiseA.then(value => {
    console.log('promiseA : ' + value);
    return new Promise(resolve => {
        setTimeout(() => {
            resolve('promiseB.resolve');
        }, 2000);
    });
});

promiseB.then(value => {
    console.log('promiseB :　' + value);
    return value; // 要return，下一個than才有值
}).then(value => {
    console.log('promiseB then 2:　' + value); 
}).then(value => {
    console.log('promiseB then 3:　' + value);
});

console.log('here we end');

// Promise.all();
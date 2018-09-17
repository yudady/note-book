# ES6 [Removing jQuery from GitHub.com frontend](https://githubengineering.com/removing-jquery-from-github-frontend/)

### 我们可以将 jQuery 与现代浏览器支持的 Web 标准的快速演化进行比较：

1. $(selector) 模式可以使用 querySelectorAll() 来替换；
2. 现在可以使用 Element.classList 来实现 CSS 类名切换；
3. CSS 现在支持在样式表中而不是在 JavaScript 中定义可视动画；
4. 现在可以使用 Fetch Standard 执行 $.ajax 请求；
5. addEventListener() 接口已经足够稳定，可以跨平台使用；
6. 我们可以使用轻量级的库来封装事件委托模式；



```
// querySelectorAll
var x = document.querySelectorAll(".example");
// classList
document.getElementById("myDIV").classList.add("mystyle");

```

### GET

```
// 總之，他回傳的都是 Promise 物件就是了~~
fetch('目標URL',{
    method: 'GET',
}).then(function(response) {
    if (response.status >= 200 && response.status < 300) {
        return response.json()
    } else {
        var error = new Error(response.statusText)
        error.response = response
        throw error
    }
})
.then(function(data) {
    // data 才是實際的 JSON 資料
}).catch(function(error) {
    return error.response.json();
}).then(function(errorData){
    // errorData 裡面才是實際的 JSON 資料
});
```

### POST

```
fetch('網址',{
    method: 'POST',
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
}).then(function checkStatus(response) {
    if (response.status >= 200 && response.status < 300) {
        return response.json();
    } else {
        var error = new Error(response.statusText)
        error.response = response;
        throw error;
    }
})
.then(function(data) {
//完成
}).catch(function(error) {
    console.log('request failed', error);
    return error.response.json();
}).then(function(errorData){
    //失敗
});
```

### FormData

> FormData 可以用來收集表單資訊，如果有個 form 代表著 <form> 標籤的 DOM，可以直接作為 FormData 建構之用：

```
let formData = new FormData(form);
formData.append('username', 'Justin');
formData.append('password', '123456');


// 如果表單中有 type = "file" 的 input 標籤，當表單 DOM 物件被當成 FormData 建構時的引數，可以直接進行檔案上傳，如果是使用 append 方法，加入 type = "file" 的 input 標籤選取之檔案，例如只選取一個檔案的情況，可以如下撰寫：



let photo = document.getElementById('photo');
formData.append('photo', photo.files[0]);

```




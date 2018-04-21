# ajax Session 權限

https://www.cnblogs.com/qixing/p/3679991.html

https://segmentfault.com/q/1010000002643953

https://www.jianshu.com/p/b6098500f2a9




1. 在发送请求之前，添加统一的验证头。
2. 请求返回时，捕捉每一个响应，做统一处理（403无权限，500服务器错误）。
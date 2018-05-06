#  [github api](https://developer.github.com/v3/repos/contents/)



## Custom media types (http 頭信息)
READMEs, files, and symlinks support the following custom media types:

- application/vnd.github.VERSION.raw
- application/vnd.github.VERSION.html



## Get the README

```
GET /repos/:owner/:repo/readme
=> https://api.github.com/repos/card-game-app/BytesJack/readme

---

GET /repos/:owner/:repo/contents/:path

https://raw.githubusercontent.com/card-game-app/BytesJack/master/README.md



```









# babel (es6轉換工具)

##　npm install -g babel-cli


1. npm install --save-dev babel babel-core babel-preset-env babel-preset-es2015 babel-cli
2. .babelrc
```
{
  "presets": ['es2015'],
  "plugins":[]
}
```

轉換命令
> babel src/index.js -o dist/index.js
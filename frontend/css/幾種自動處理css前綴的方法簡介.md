# 几种自动处理css前缀的方法简介 （Autoprefixer）

## 在gulp中，你可以安装npm包gulp-postcss来启用Autoprefixer。


```
var gulp = require('gulp');
gulp.task('autoprefixer', function () {
  var postcss      = require('gulp-postcss');
  var autoprefixer = require('autoprefixer');

  return gulp.src('./postcss/*.css')
    .pipe(postcss([ autoprefixer({ browsers: ['last 2 versions'] }) ]))
    .pipe(gulp.dest('./dist/postcss'));
});
```

## webpack

```
var autoprefixer = require('autoprefixer');

module.exports = {
  module: {
    loaders: [
        {
            test:   /\.css$/,
            loader: "style-loader!css-loader!postcss-loader"
        }
    ]
  },
  postcss: [ autoprefixer({ browsers: ['last 2 versions'] }) ]
}
```
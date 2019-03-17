var gulp = require('gulp');               // 載入 gulp
var connect = require('gulp-connect');		// 載入 http-server
var livereload  = require('gulp-livereload');  // 載入 gulp-livereload


// 自定義參數
var config = {
	src : 'src'
}

gulp.task('connect', function() {
  connect.server({
		root: config.src,  // livereload  根目錄
		port: 3000,
        host: 'localhost',
        livereload: true
  });
});

gulp.task('reload', function () {
	gulp.src([config.src + '/*.*'])	// 需要reload的目錄
		.pipe(livereload());
});

gulp.task('watch', function () {
	livereload.listen({
		start: true,
		basePath: config.src
	});
	
	// 監控
	gulp.watch([config.src + '/*.html'], ['reload']);
	gulp.watch([config.src + '/*.js'], ['reload']);
	
});

gulp.task('default', ['connect', 'watch' ,'reload']);




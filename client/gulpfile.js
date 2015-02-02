var gulp       = require('gulp'),
    plumber    = require('gulp-plumber'),
    browserify = require('gulp-browserify'),
    uglify     = require('gulp-uglify');

gulp.task('js', function () {
  return gulp.src('./src/app.js', { read: false })
    .pipe(plumber())
    .pipe(browserify({
      transform: ['reactify'],
      extensions: ['.jsx', '.js', '.json'],
      insertGlobals: false,
      debug: false
    }))
    .pipe(uglify())
    .pipe(gulp.dest('./build'));
});

gulp.task('watch', function () {
  gulp.watch(['js/**/*.js'], ['js']);
});

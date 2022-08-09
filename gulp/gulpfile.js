/**
 * Compiler for CSS and JS.
 */

const gulp = require('gulp');
const noop = require('gulp-noop');
const rename = require('gulp-rename');
const del = require('del');
const sass = require('gulp-sass')(require('sass'));
const sassGlob = require('gulp-sass-glob');
const autoprefix = require('gulp-autoprefixer');
const cleanCss = require('gulp-clean-css');
const babel = require('gulp-babel');
const plumber = require('gulp-plumber');
const terser = require('gulp-terser');
const log = require('fancy-log');

// ------
// Config
// ------
const basePath = {
  src: '/app/src/',
  dist: '/app/dist/',
};

const path = {
  styles: {
    src: `${basePath.src}scss/`,
    dist: `${basePath.dist}css/`
  },
  scripts: {
    src: `${basePath.src}js/`,
    dist: `${basePath.dist}js/`
  },
};

const sassConfig = {
  outputStyle: 'expanded',
  includePaths: [
    '/srv/node_modules/node-normalize-scss/',
    '/srv/node_modules/breakpoint-sass/stylesheets/'
  ]
};

// -------------
// Compile SASS.
// -------------
function compileSASS() {
  return gulp
    .src(`${path.styles.src}**/*.scss`)
    .pipe(sassGlob())
    .pipe(
      path.env === 'development'
        ? sass(sassConfig).on('error', function(err) {
          const chalk = require('chalk');
          log.error(chalk.black.bgRed(' SASS ERROR' + chalk.white.bgBlack(' ' + (err.message.split('  ')[2]) + ' ')));
          log.error(chalk.black.bgRed(' FILE:' + chalk.white.bgBlack(' ' + (err.message.split('\n')[0]) + ' ')));
          log.error(chalk.black.bgRed(' LINE:' + chalk.white.bgBlack(' ' + err.line + ' ')));
          log.error(chalk.black.bgRed(' COLUMN:' + chalk.white.bgBlack(' ' + err.column + ' ')));
          log.error(chalk.black.bgRed(' ERROR:' + chalk.white.bgBlack(' ' + err.formatted.split('\n')[0] + ' ')));
          return this.emit('end');
        })
        : sass(sassConfig)
    )
    .pipe(autoprefix())
    .pipe(path.env === 'production' ? cleanCss() : noop())
    .pipe(gulp.dest(path.styles.dist));
}

// ---------------------------------------------------
// Copy js from src to dist and run through terser if necessary.
// ---------------------------------------------------
function compileJS() {
  return gulp
    .src(`${path.scripts.src}**/*.js`)
    // Stop the process if an error is thrown.
    .pipe(plumber())
    // Transpile the JS code using Babel's preset-env.
    .pipe(babel({
      presets: [
        ['@babel/env', {
          modules: false
        }]
      ]
    }))
    .pipe(path.env === 'production' ? terser() : noop())
    .pipe(
      rename({
        suffix: '.min'
      })
    )
    .pipe(gulp.dest(path.scripts.dist));
}

// ----------------------
// Function to run watch.
// ----------------------
function runWatch() {
  gulp.watch(`${path.styles.src}**/*.scss`, compileSASS);
  gulp.watch(`${path.scripts.src}**/*.js`, compileJS);
}

// -----------
// Watch task.
// -----------
gulp.task('watch', gulp.series(runWatch));

// -----------------------
// Function to clean dist.
// -----------------------
function cleanDist() {
  log(`Clean all files in ${basePath.dist} folder`);
  return del([basePath.dist], { force: true });
}

// ------------------------------------------
// Helper function for selecting environment.
// ------------------------------------------
function environment(env) {
  log(`Running tasks in ${env} mode.`);
  return (path.env = env);
}

// --------------------------------------
// Set environment variable via dev task.
// --------------------------------------
gulp.task('dev', done => {
  environment('development');
  done();
});

// ---------------------------------------
// Set environment variable via prod task.
// ---------------------------------------
gulp.task('prod', done => {
  environment('production');
  done();
});

// -------------------------------------
// Build development css & scripts task.
// -------------------------------------
gulp.task(
  'development',
  gulp.series('dev', cleanDist, compileSASS, compileJS),
  done => {
    done();
  }
);

// ----------------
// Production task.
// ----------------
gulp.task(
  'production',
  gulp.series('prod', cleanDist, compileSASS, compileJS),
  done => {
    done();
  }
);

// -------------
// Default task.
// -------------
gulp.task('default', gulp.series('development'), done => {
  done();
});

'use strict';

const { dest, parallel, series, src, task, watch } = require('gulp');
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

let production = false;

const dataPath = process.env.DATA_PATH;
const distPath = `${dataPath}/${process.env.DIST_FOLDER}`;
const jsGlob = `${dataPath}/${process.env.SRC_FOLDER}/js/**/*.js`;
const scssGlob = `${dataPath}/${process.env.SRC_FOLDER}/scss/**/*.scss`;

const sassConfig = {
  outputStyle: 'expanded',
  includePaths: [
    `${process.env.GULP_PATH}/node_modules/node-normalize-scss/`,
    `${process.env.GULP_PATH}/node_modules/breakpoint-sass/stylesheets/`
  ]
};

function errorOnSASS(err) {
  log.error('SASS ERROR ' + (err.message.split('  ')[2]));
  log.error('FILE: ' + (err.message.split('\n')[0]));
  log.error('LINE: ' + err.line);
  log.error('COLUMN: ' + err.column);
  log.error('ERROR: ' + err.formatted.split('\n')[0]);

  return this.emit('end');
}

function compileCSS() {
  return src(scssGlob)
    .pipe(sassGlob())
    .pipe(production ? sass(sassConfig) : sass(sassConfig).on('error', errorOnSASS))
    .pipe(autoprefix())
    .pipe(production ? cleanCss() : noop())
    .pipe(dest(`${distPath}/css/`));
}

function compileJS() {
  return src(jsGlob)
    // Stop the process if an error is thrown.
    .pipe(plumber())
    // Transpile the JS code using Babel's preset-env.
    .pipe(babel({ presets: [['@babel/env', { modules: false }]] }))
    .pipe(production ? terser() : noop())
    // Rename JS files with suffix .min.js.
    .pipe(rename({ suffix: '.min' }))
    .pipe(dest(`${distPath}/js/`));
}

function runWatch() {
  watch(scssGlob, compileCSS);
  watch(jsGlob, compileJS);
}

function cleanDistFolder() {
  return del([distPath], { force: true });
}

function useProductionMode(cb) {
  production = true;
  cb();
}

// Watch task.
task('watch', series(runWatch));

// Build development CSS & JS.
task('development', series(cleanDistFolder, parallel(compileCSS, compileJS)));

// Build production CSS & JS.
task('production', series(useProductionMode, cleanDistFolder, parallel(compileCSS, compileJS)));

// Default task.
task('default', series('development'));

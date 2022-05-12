---
title:	"Sane Jekyll & NPM Setup"
date:		2022-03-17
layout:	post
categories: web-dev tech
---
Jekyll's developer and user friendly toolkit quickly streamlines building quality static blogs and websites. However, including Javascript sourced from node_modules can cause issues if you are hosting on a site like Github Pages. Resolving the complications is relatively straight forward. Not only will the github repository stay lean, but the code will work in safe mode as well.

The JavaScript from <code>node_modules</code> will be slimmed and output into the source directory with any loaded dependencies.

#### Setting Up the Environment
First be sure to have Jekyll and NPM installed on your computer. Once that is done, create the your working directory by using the following.

First create the project directory with Jekyll.
```
$ jekyll new projectname
$ cd projectname
```

Next set and install any node_modules you plan to use.
```
$ npm init -y
$ npm install webpack-demo webpack-cli --save-dev
```


#### File Structure
Next, move the files and directories generated so they resemble this map. Create directories as needed if they do not already exit.

```
├── _config.yml
├── _site
├── Gemfile
├── Gemfile.lock
├── node_modules
├── package.json
├── package-lock.json
├── src
│   ├── 404.html
│   ├── about.markdown
│   ├── assets
│   │   ├── css
│   │   ├── img
│   │   └── js
│   │       └── main.js
│   ├── index.js
│   ├── index.markdown
│   ├── _layouts
│   │   └── default.html
│   ├── _posts
│   └── _sass
│       ├── main.css
│       └── _variables.scss
└── webpack.config.js
```
#### Config Set-Up

First we're going to edit the <code>package.json</code> we generated with <code>npm init</code>. We need it to include <code>"build":</code> under scripts. Be sure to remember the commas.

```
{
  "name": "projectname",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
	 "build": "webpack"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "bootstrap": "^5.1.3"
  },
  "devDependencies": {
    "webpack-cli": "^4.9.2",
    "webpack-demo": "^1.0.0"
  }
}
```


Next Webpack's <code>webpack.config.js</code> needs to be configured properly in order to input, build, then output to the <code>src</code> directory. 

```
const path = require("path");

module.exports = {
	entry: ".src/index.js",
	output: {
		filename: "main.js"
		path: path.join(__direname, "./src/assets/js"),
	}
};
```

Finally the last config to edit is the <code>_config.yml</code> to include the following in order to load stylesheets from node_modules.

```
source: src
```
We will add bootstrap in this example, as if we added it through <code>npm</code> by creating a symbolic link to bootstrap from the <code>_sass</code> directory.

```
$ cd src/_sass/
$ [editor] style.scss
```

```
// Custom.scss
// Option A: Include all of Bootstrap

// Include any default variable overrides here (though functions won't be available)

@import "../node_modules/bootstrap/scss/bootstrap";

// Then add additional custom code here

// Custom.scss
// Option B: Include parts of Bootstrap

// 1. Include functions first (so you can manipulate colors, SVGs, calc, etc)
@import "../node_modules/bootstrap/scss/functions";

// 2. Include any default variable overrides here

// 3. Include remainder of required Bootstrap stylesheets
@import "../node_modules/bootstrap/scss/variables";
@import "../node_modules/bootstrap/scss/mixins";

// 4. Include any optional Bootstrap components as you like
@import "../node_modules/bootstrap/scss/root";
@import "../node_modules/bootstrap/scss/reboot";
@import "../node_modules/bootstrap/scss/type";
@import "../node_modules/bootstrap/scss/images";
@import "../node_modules/bootstrap/scss/containers";
@import "../node_modules/bootstrap/scss/grid";

// 5. Add additional custom code here

```
If everything is properly organized, it should all load and run properly. Before committing to github, be sure to properly add to your <code>.gitignore</code>

```
.sass-cache
.jekyll-cache
.jekyll-metadata
vendor
node_modules
```


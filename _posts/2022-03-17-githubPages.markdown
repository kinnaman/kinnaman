---
title:	"Jekyll + NPM + Bootstrap + Webpack + Bootstrap"
date:		2022-03-17
layout:	post
catagories: web-dev tech
---
Due to default behavior of NPM and Jekyll, adding <code>node_modules</code> to Jekyll's <code>include:</code> section of its config causes the site size to balloon in size. In order to keep unnecessary bulk down in GitHub repos or the hosting server, a few precursory steps can remedy the problems arisen from using NPM with Jekyll. For this example, we're using Bootstrap downloaded through NPM and including it in Jekyll's safe mode.The JavaScript from <code>node_modules</code> will be slimmed by Webpack while the stylesheets will be called through Jekyll config.

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
$ npm install bootstrap
$ npm install webpack-demo webpack-cli --save-dev
```


#### File Structure
Next, move the files and directories generated so they resemble this map. Create directories as needed if they do not already exit.

```
├── _config.yml
├── dist
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
First we're going to edit the <code>package.json</code> we generated with <code>npm init</code>. We need it to include <code>"build":</code> under scripts. Be sure to remember the commas.

```
{
  "name": "projectname",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
	 "build":
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
		path: paath.join(__direname, "./src/assets/js"),
	}
};
```

Finally the last config to edit is the <code>_config.yml</code> to include the following in order to load stylesheets from node_modules.

```
sass:
	load_paths:
		- _sass
		- node_modules
```

If everything is properly organized, it should all load and run properly.


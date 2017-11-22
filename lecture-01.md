# Web Frameworks and APIs

Michael Joanathan Lee // michael.lee@fh-kiel.de

Winter Term 2017


## Course Organization


- 10 lectures and 5 lab sessions


- ECTS credits will be granted based on projects 


- projects will be done in groups of 4


- appointments available Tuesdays and Thursdays on mail request 


- no lectures Dec 21st - Jan 6th


- no lab session Dec 19th


- additional lab session Jan 11th


# NPM

Package and Dependency Management

https://www.npmjs.com

### Dependency Organization 

- package Management System of NodeJS now widely used throughout the Javascript universe


- module description and dependencies are provided through the `package.json` file in the module root dir


- modules are organized in a tree


- within that tree several different versions of the same module can exist 


- a module can only access its direct dependees.


- there are two kinds of dependencies:
  * 'regular' dependendencies which lead to a recursive dependency tree 
  * 'peer dependencies': dependee expects depender to provide module


- regular dependencies can be 
  * `dependencies`: required by the module at runtime
  * `devDependencies`: required to build the module


### Importing Modules

A global function `require` is provided to load modules:
```javascript
const importedName = require('module')
```
Each module will only be loaded once. Subsequent calls to require will just return the loaded module.


### Exporting from Modules

CommonJS modules can use two variables to export:
* `exports`: used for modules with multiple exports
* `module.exports`: used for modules with single export

A pseudo implementation of this behaviour
```javascript
const importedName = function() {
    const module = {exports: {}}
    const exports = module.exports
    
    // start module module code loaded from file 
    
    // module has multiple exports
    
    exports.a = 1
    exports.b = 2
    
    // module has a single export
    
    module.exports = 3
    
    // end module code loaded from file
    
    return module.exports
}()
```

### How NodeJS Wraps Module Code

The require function can not be a singleton, since it has a different context for different modules throughout the
dependency tree.


NodeJS actually wraps the module as a function and passes a `require` function within that modules context.


Some other contextual values such as filename and source path are passed to the module


```javascript
(function (exports, require, module, __filename, __dirname) {
  function add (a, b) {
    return a + b
  }

  module.exports = add
})
```

### ES6 Imports and CommonJS Modules

A CommonJS module import
```javascript
const importName = require('module')
```

can be written as
```javascript
import importName from 'module'
```

By using destructuring we can import specific parts of a module:
```javascript
import {functionA, classB} from 'module'
```


### Adding Modules

Initialize a project:
```bash
$ npm init
```

Install a dev dependency:
```bash
$ npm i --save-dev react-loader
```

Install a normal dependecy:
```bash
$ npm i --save react
```

Install something system wide:
```bash
$ sudo npm i -g webpack
```


# Babel

https://babeljs.io


### Concept

transpile 

- newer Javascript code to Javascript understood by targeted NodeJS and browser versions
- other languages or language extensions
  
to Javascript code to Javascript understood by targeted NodeJS and browser versions


```javascript
// This ES6 code
class A {
    f() {
        return () => console.log(this.a)
    }
}

// could become something like
function A() {
    var _this = this
    this.f = function() {
        return function() {console.log(_this.a)}
    }
}
```


### Install

Make babel command available globally:
```bash
$ sudo npm i --save-dev babel-cli
```

Install the required plugins and presets for the project locally:
```bash
$ npm i --save-dev babel-preset-env
$ npm i --save-dev babel-plugin-transform-decorators-legacy
```


### Configure and Run

Create a basic `.babelrc` config file in the project root dir:

 ```json
{
  "presets": [
    ["env", {"targets": {"node": "6.11"}}]
  ],
  "plugins": [
    "transform-decorators-legacy"
  ]
}
```

Although there are many babel presets available its best to use 'env' and specify your target platform.

Run babel on all files in `src`
```bash
babel src -d lib --source-maps inline
```


# Webpack

Code and Resouce Bundling

https://webpack.js.org


### Installation and Usage

To make the `webpack` command available install webpack globally

```bash
$ sudo npm i -g webpack 
```

You will need to configure your project through a `webpack.config.js` file in your project root. The most basic webpack
config will be:

```javascript
mdule.exports = {
    entry: 'index.js',
    output: {
        path: __dirname + '/bundles',
        filename: 'bundle.js',
    },    
}
```


### Using the Bundle

You can now use your bundle in your pages: 

```html
<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Webpack Bundle Sample Page</title>
    </head>
    <body>
        <h1>MI131</h1>
        <script src="bundles/public.bundle.js"></script>
    </body>
</html>
```

To view the result we can use `webpack-dev-server`:
```bash
$ sudo npm i -g webpack-dev-server
$ webpack-dev-server --open
```
This will open your page in a browser and rebundle and reaload your page on changes.


### Generate HTML with Bundles

To copy the html file to the output directory and automatically load all bundles at the end of the body:

- Install the `HtmlWebpackPlugin`

```bash
$ npm i --save-dev html-webpack-plugin
```

- Remove the `<script ...></script>` line from the `index.html` file

- add the following to the webpack config:

```javascript
const HtmlWebpackPlugin = require('html-webpack-plugin') 
// other imports ...

module.exports = {
    // change output dir name
    output: {
        path: __dirname + '/dist'
    },
    // generate HTML in dist
    plugins:  [
        new HtmlWebpackPlugin({template: __dirname + '/index.html'})
    ]
    // other config ...   
}
```

### Remove Unused Files from Output Directory

If files are no longer part of the project but have created in the `dist` directory its usefull to have these files
removed:

- Install the `CleanWebpackPlugin`

```bash
$ npm i --save-dev clean-webpack-plugin
```


- Add the following to your webpack config:

```javascript
const CleanWebpackPlugin = require('clean-webpack-plugin') 
// other imports ...

module.exports = {
    // change output dir name
    output: {
        path: __dirname + '/dist'
    },
    // generate HTML in dist
    plugins:  [
        new CleanWebpackPlugin(['dist']),
        // other plugins ...
    ]
    // other config ...   
}
```


### Add Source Map

Associate the code in a bundle with the original location in the source code.

```javascript
console.log('bundle loaded') // index.js:1 => bundle.js:9
```

To enable source map in the bundle add the following to the webpack config:


```javascript
module.exports = {
    devtool: 'inline-source-map',
    // other config ...   
}
```

Now the debugger in your browser should display the original source files instead of the bundles.


### Transpile with Babel during Bundling

To transpile code with babel while bundling you will need the babel core and the babel loader for webpack.
```bash
$ npm i --save-dev babel-core babel-loader
```

```javascript
module.exports = {
        rules: [
            {
                test: /\.js$/,
                use: 'babel-loader',
                exclude: /node_modules/
            },
        ],
    },
    // other config ...
}
```

# React

Component Oriented Rendering Library

https://reactjs.org/


### Principles


- just rendering and event handling library (unlike frameworks EmberJS or AngularJS)


- UI is organized as component tree


- components are functions that produce UI subtrees from state


- keep as little state in the UI as possible


- just re render entire UI subtree on update


- keep DOM subtrees for performance reasons 


- works well with immutable state libraries (redux)


### JSX

Extension to the Javascript langauge spec, to allow to write HTML structure, that is compiled to React code:

```jsx
const clickButton = () => {
    console.log("click click")
}

const c = <div>
    <button onClick={clickButton}>Click Me!</button>
    <MyComponent strongProp="sample string" />
</div>
```

- not required for react but highly convenient


- use `{...}` to embed Javascript code in the HTML.


- only use JSX in actual UI components. Don't pollute your model and application logic with JSX.


### Transpile React JSX

Install the JSX transpiler

```bash
npm i --save-dev babel-preset-react
```
Add react to your `.babelrc`

 ```json
 {
       "presets": [
         ["env",{"targets": {"chrome": "62"}}],
         "react"
       ],
       // other config ...
 }
 ```
 
And alter `rules` section in `webpack.config.js`
 
 ```javascript
rules: [
    {
        test: /\.jsx?$/, // matches .js and .jsx
        use: 'babel-loader',
        exclude: /node_modules/
    },
]
```

### First React App

Add a root element for react in your `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MI131</title>
</head>
<body>
    <div id="main"></div>
</body>
</html>
```

Rename `index.js` to `index.jsx` and change in `webpack.config.js`:
```javascript
entry: 'src/index.jsx'
```


### React Components

Components are the building blocks of your react app.
Use Components by embedding them in your HTML 

```jsx
<ComponentName prop1="string value" prop1={javascript value} />
```

Component rendering output has two kinds of input:
    
- props (`prop1`, `prop2`)    
- state (set via `setState(...)`)
    
Props are like function arguments and state is like private object properties.


### Creating React Components

Extend `React.Component` and implement `render()`:

```jsx
// imports ...

class RootComponent extends React.Component {
    render() {
        console.log('render root component')
        return <h1>Root Component Body</h1>
    }
}

ReactDom.render(<RootComponent />, document.getElementById("main"))
```

### Stateless Components

Components with no internal state are equal to pure functions, so you can more elegantly define them as:

```jsx
// imports ...

function RootComponent(props) {
    console.log('render root component')
    return <h1>Root Component Body</h1>
}

ReactDom.render(<RootComponent />, document.getElementById("main"))
```


### Passing Data through Props

We can pass data through props:

```jsx
import React from 'react'
import ReactDom from 'react-dom'


class RootComponent extends React.Component {
    render() {
        const {message, handleClick} = this.props
        console.log('render root component')
        return <div>
            <button onClick={handleClick}>Click Me!</button>
            <h1>{message}</h1>
        </div>
    }
}

const printHello = () => alert('Hello!')

ReactDom.render(<RootComponent message="Hello!" handleClick={printHello} />, document.getElementById("main"))
```


### Stateful Components (App Skeleton)

Set up an app with a very basic name input component:

```jsx
class NameInput extends React.Component {
    constructor(props) {
        super(props)

        // initial state and handlers ...
    }

    render() {
        // visual representation and handlers ...
    }
}

const handleNameInput = name => 
    console.log('name set to:', name.name, name.surname)

ReactDom.render(
    <NameInput onChange={handleNameInput} />, 
    document.getElementById("main"))
```

### Stateful Components (Constructor)

In the constructor function we define handlers and the initial state:

```jsx
constructor(props) {
    super(props)

    this.state = {name: '', surname: ''}

    this.handleNameChange = event => 
        this.setState({name: event.target.value})
    this.handleSurnameChange = event => 
        this.setState({surname: event.target.value})
    this.handleSubmit = event => {
        const {onChange} = this.props
        if (onChange) {
            onChange(Object.assign({}, this.state))
        }
        event.preventDefault()
    }
}
```

Note that calling `preventDefault` is important for form submits.

### Stateful Components (Constructor)

In the render function we define the visual representation and register the event handlers:

```jsx
render() {
    return <form onSubmit={this.handleSubmit}>
        <div>
            <label>name</label>
            <input type="text" 
                value={this.state.name} 
                onChange={this.handleNameChange}/>
        </div>
        <div>
            <label>surname</label>
            <input type="text" 
                value={this.state.surname} 
                onChange={this.handleSurnameChange}/>
        </div>
        <input type="submit" value="Ok" />
    </form>
}
```

### Lists (Arrays)

- You can directly use lists (arrays) of Components into your HTML markup.


- The correct ordering of items is preserved.


- React requires each item in the list to have a `key` property with a value unique within the list for each item.

```jsx
// imports ...

const names = [
    'phil',
    'pete',
    'bob'
]

const renderedNames = names.map(name => <li key={name}>{name}</li>)

ReactDom.render(
    <ol>{renderedNames}</ol>, 
    document.getElementById("main"))
```

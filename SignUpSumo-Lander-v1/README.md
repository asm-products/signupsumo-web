# Fueled Boilerplate #

The start point for all new frontend projects at Fueled. The project utilizes technologies and methods to make development easier, and more consistent across the team.

The Fueled Boilerplate uses Gulp for task running, significantly speeding up development by automatically doing things like minifying code, autoprefixing properties, and concatenating files.

We also utilize SCSS, which allows us to do things like split up our SCSS files into more maintainable, obvious partials.

## First time setting up the Boilerplate ##

Follow these instructions for the **first time** you use the Boilerplate. This installs all the underlying dependencies needed to run the Boilerplate. Once these are installed, you should be able to use the Fueled Boilerplate as many times as you like.

1. Install XCode (available from the Mac App Store for free), and then install the Command Line Tools (CLT). Details on how to do this [are available here, depending on your Xcode/OS X verison](http://stackoverflow.com/questions/9329243/xcode-4-4-and-later-install-command-line-tools)
    1. Alternatively, if you don't want to install the entire XCode package just to get access to the CLT (it's a 2.5GB download), you can grab the [OSX GCC Installer](https://github.com/kennethreitz/osx-gcc-installer) which gives you all the Command Line Tools you'll need.
    2. **Do not install both, this can cause issues**
2. Install [NPM (Node Package Manager)](http://nodejs.org) from the Node.js homepage
3. Head to [the Gulp Github repo](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md#getting-started) and follow the instructions to install Gulp
    1. open Terminal and run `sudo npm install -g gulp` (you'll be asked for your password)
    2. That should install everything you'll need to make Gulp work.
4. Install [RVM](https://rvm.io/) so we can manage which version of Ruby we are currently running.
    1. RVM (Ruby Version Manager) provides an easy way to switch between Ruby versions. You can install it by running `\curl -sSL https://get.rvm.io | bash -s stable` in Terminal.
    2. Once it's installed, install & start using Ruby version 1.9.3. You can do this by running the following commands:
        1. `rvm get head`
        2. `rvm install 1.9.3 --with-gcc=clang`
        3. `rvm use 1.9.3`
5. Install [Sass](http://sass-lang.com/install). Sass is the framework upon which SCSS is based. It's a Ruby gem, and so installation is fairly straight forward.
    1. Run `sudo gem install sass` to install Sass.

Looks like a lot, but it should be relatively straight forward!

## Creating a Boilerplate project ##

To create a new Boilerplate project, clone the Github repository into the chosen directory. For this example, a new Boilerplate project called `todo-app` will be created. (Don't copy the leading `$` in these examples, they are there to show a new command input).

1. In Terminal, use `cd` to navigate to the directory where you keep all your local builds.

    ``` bash
    $ cd ~/Sites/
    ```
2. Clone **Fueled Boilerplate** into a new directory called `todo-app`

    ``` bash
    $ git clone https://github.com/Fueled/fueled-boilerplate.git todo-app
    ```

3. You'll now have a Fueled Boilerplate project set up in `~/Sites/todo-app`.

4. `cd` into the new `todo-app` folder

    ``` bash
    $ cd todo-app
    ```

5. Install all the Node Module dependencies needed to make the Fueled Boilerplate work

    ``` bash
    $ sudo npm install
    ```

    This may take a while, there's quite a few things to install.

## Kicking off the gulp

Once you've got it all installed, you'll need to run the gulp task to watch for changes and run the various parts of gulfile.js

``` bash
$ gulp
```

Gulp build will run each of the build tasks as if each has had a change made to it. Helpful for when pulling down after changes have been made by another party/elsewhere.

``` bash
$ gulp build
```


## Working with the Fueled Boilerplate

The Fueled Boilerplate is set up to encourage best practices and – crucially – maintainability of code.

### SCSS ###

The SCSS for the Fueled Boilerplate is split up into 3 directories, `framework`, `modules`, and `ui`.

The SCSS files themselves are commented with top-level explanations of how to use them, and what other partials are referenced.

Files in `framework` are reserved for behind-the-scenes type-work. Things like color variables, setting up typography sizes, SCSS Mixins, CSS Helpers, etc. are all included here. We also include the base SCSS partial here, which sets up fundamental CSS rules.

Files in `modules` are reserved for the styling of core elements and underlying structure. Partials in the `modules` folder will include the visual style of repeatable elements. So how buttons, blocks, callouts, lists, etc. look.

Files in `ui` are reserved for more intricate declarations. Partials in the `ui` folder could closely mirror the naming conventions of the `modules` folder, but contain styles relating to individual elements.

#### Folder Structure Example – Modules & UI ####

Say you've got a SCSS Module you want to create, for buttons. It would make absolute sense to create a `modules/_buttons.scss` file. The contents, at a very basic level, could look like this:

    .btn {
        @extend %btn;
        background:$color-btn-primary;
        color:$color-btn-primary-text;  
        &:hover {
            background:$color-btn-primary-hover;
            border-color:$color-btn-primary-hover;
            color:$color-btn-primary-text;
        }
        &:active,
        &:focus {
            background:$color-btn-primary-active;
            border-color:$color-btn-primary-active;
            color:$color-btn-primary-text;
        }
    }

    .btn--secondary {
        @extend %btn;
        color:$color-btn-secondary-text;
        &:hover {
            background:$color-btn-secondary-hover;
            border-color:$color-btn-secondary-hover;
            color:$color-btn-secondary-text-hover;
        }
        &:active,
        &:focus {
            background:$color-btn-secondary-active;
            border-color:$color-btn-secondary-active;
            color:$color-btn-secondary-text-active;
        }
    }

This file can be referenced multiple times in your HTML, and you know exactly what the outcome will be each time you add a class of `.btn` or `.btn--secondary`.

However, say you had a button that you wanted to position in the top right of a parent element. That declaration should live in the `ui/_buttons.scss` file, as it's modifying the property of an element which isn't universally used. So `ui/_buttons.scss` could look something like this:

    .btn {
        .add-to-cart & {
            position:absolute;
            right:1em;
            top:1em;
        }
    }

On a basic level, if a style is going to be repeated in various places, a separate class should be created for it and it should live in the `modules` folder. If it's a one-off style declaration, it should most likely live in the `ui` folder.

### JS ###

Through the magic of Gulp, we're able to maintain our Javascript in smaller partial files too, making debugging and development a whole lot easier.

We attach all functionality to a global `g` object. Take a look through `assets/js/g.js`, `assets/js/partials/demo/js` and `assets/js/main/js` to read the comments on how this works.

To add a new partial, simply create a new file in `assets/js/partials`, and Gulp will automatically concatenate it to the main JS file.

The benefits of using these small partials in this way are two fold.

Firstly, it encourages an OOP approach to writing Javascript, which when written correctly can hugely increase productivity between team members because the same methodologies are being used across the board.

Secondly, it's much easier to find issues with code when dealing with 100 line partials, as opposed to a 2000 line full file.

### Unsupported browsers

Unsupported browsers is a bit of a misnomer as we’re actually using it here to describe browsers that require extra styling to __be__ supported (at least to a basic level).

Since autoprefixer handles the majority of browser support, this is mainly to cater for IE8/IE7 issues (if the project dictates that level of support) and as such the separate stylesheet will only be served to IE8 and below.

`unsupported.scss` will import `framework/_variables.scss`, `framework/_color.scss`, `framework/_mixins.scss` and `framework/_type.scss` by default so that these variables etc can be declared once for all stylesheets.

Rules to be applied to the unsupported browsers should then be contained respectively within `framework/_unsupported.scss`, `modules/_unsupported.scss` and `ui/_unsupported.scss` depending on what they are fall-back for.

### Example – _typography.scss

For example, `modules/_typography.scss` uses `rem()` to handle margins etc which isn’t supported by IE8, so the fall-back would sit in `modules/_unsupported.scss` and be labelled with its origin (in this case _typography.scss) to make it easy to understand which rules it’s related to.

### License

The MIT License (MIT)

Copyright (c) 2013-2014 Fueled (fueled.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
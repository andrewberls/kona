# Kona
Kona is an HTML5 game engine, written in CoffeeScript, for CoffeeScript. It is purpose-built for creating 2D platformers
using the canvas element, and provides a simple starting point for game developers to run with.


## Features
Kona handles a number of tasks to let you focus on developing your game, including (but not limited to):
* A flexible entity model for defining your game objects
* Canvas rendering
* Playing audio
* Collision detection
* Basic physics
* Simple mechanisms for defining level layouts and transitions
* Drop-in animations using spritesheets
* Easy keyboard bindings
* A powerful generic event binding/triggering system


## Getting Started
The [examples](https://github.com/andrewberls/kona/tree/master/examples) directory contains a number of examples
displaying both basic and advanced use of Kona. A documentation webpage is currently a work in progress, and the source
code is extensively annotated based on [TomDoc](http://tomdoc.org/).

Kona was originally started to power the [Debugger](https://github.com/andrewberls/kona/tree/master/examples/debugger)
game, which can be considered the reference implementation of a Kona game.


## Disclaimer
Kona is very much a work in progress. The groundwork is in place, although parts are subject to change at any time,
and it's probably not ready for your production-grade game (yet).


## Building
Kona projects are built using [Arabica](http://andrewberls.github.io/arabica/), a build tool for CoffeeScript/JavaScript.
If you're in the root directory of your project and have an `arabica.json` file configured, you can run `arabica build` to
compile a single file for distribution.


## Contributing
There's much to be done, and contributions are always welcome!

1. Fork the project
2. Make your changes
3. Build the framework using `arabica build` in the root directory
4. Pull request!

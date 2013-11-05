all: build test

build:
	arabica build
	arabica build examples/debugger/

test:
	coffee -o spec/build/ -c spec/src/*.coffee

clean:
	arabica clean

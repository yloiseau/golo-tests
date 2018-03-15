
all: test

.PHONY: test
test: build
	@golo golo --classpath build --files main.golo

.PHONY: build
build:
	@mkdir -p build
	@javac -d build src/java/net/yloiseau/tools/*.java
	@golo compile --output build src/golo/net/yloiseau/*.golo

.PHONY: clean
clean:
	@rm -rf build

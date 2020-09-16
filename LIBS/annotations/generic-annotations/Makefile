
.PHONY: test
test:
	mkdir -p build
	javac -d build src/test/java/golo/test/annotations/*.java
	golo compile --classpath build --output build src/main/golo/gololang/meta/Annotations.golo 
	golo compile --classpath build --output build src/test/ressources/for-macros/annotation-macros.golo
	golo compile --classpath build --output build src/test/ressources/for-macros/Annotate.golo
	golo golo --classpath build,/usr/share/java/hamcrest-all.jar --files src/test/ressources/for-macros/annotation.golo
	@echo "compile errors"
	@echo "    not on method"
	-@golo compile --classpath build --output build notonmethod.golo 2>&1 | grep 'Annotation .* not applicable' > /dev/null && echo ok || false
	@echo "    not on type"
	-@golo compile --classpath build --output build notontype.golo 2>&1 | grep 'Annotation .* not applicable' > /dev/null && echo ok || false

.PHONY: clean
clean:
	-@find . -name '*.class' -exec rm -f {} \;
	-@rm -rf build

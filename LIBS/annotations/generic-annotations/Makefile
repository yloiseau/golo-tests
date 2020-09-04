
.PHONY: test
test: clean
	@javac annotations/*.java
	@golo compile tool.golo 
	@golo compile AnnotationMacros.golo
	@golo compile Annotate.golo
	@echo "golo test"
	-@golo golo --files test.golo
	@echo "compile errors"
	@echo "    not on method"
	-@golo compile notonmethod.golo 2>&1 | grep 'Annotation .* not applicable' > /dev/null && echo ok || false
	@echo "    not on type"
	-@golo compile notontype.golo 2>&1 | grep 'Annotation .* not applicable' > /dev/null && echo ok || false

.PHONY: clean
clean:
	-@find . -name '*.class' -exec rm -f {} \;

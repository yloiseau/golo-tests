# Import resolution issue

See [#340](https://github.com/eclipse/golo-lang/issues/340).

When resolving relative functions (i.e. not fully qualified), and thus looking up in the imported classes/modules/packages, the resolution sometime yields unexpected results.
The main issue is probably in [`FunctionCallSupport::findClassWithStaticMethodOrFieldFromImports`](https://github.com/eclipse/golo-lang/blob/master/src/main/java/org/eclipse/golo/runtime/FunctionCallSupport.java#L286)

This scripts try to cover all situations: absolute call, relative to an imported class, relative to a class in an imported package, and so on.

Usage:
- use the `fix/340-imports` branch of https://github.com/yloiseau/golo-lang.git
- `./test.sh` or `./test.sh -v` for verbose output

# Import resolution issue

See [#340](https://github.com/eclipse/golo-lang/issues/340).

When resolving relative functions (i.e. not fully qualified), and thus looking up in the imported classes/modules/packages, the resolution sometime yields unexpected results.
The main issue is probably in [`FunctionCallSupport::findClassWithStaticMethodOrFieldFromImports`](https://github.com/eclipse/golo-lang/blob/master/src/main/java/org/eclipse/golo/runtime/FunctionCallSupport.java#L286)

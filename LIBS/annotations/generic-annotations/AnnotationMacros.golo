
module AnnotationMacros

import gololang.ir

&use("Tool")

&annotationWrapper(annotations.OnMethod.class)
&annotationWrapper(annotations.OnClass.class)
&annotationWrapper(annotations.OnClassInherit.class)
&annotationWrapper(annotations.OnBoth.class)
&annotationWrapper(annotations.OnAll.class)
&annotationWrapper(annotations.OnAll.class, "OnMultiple")
&annotationWrapper(annotations.WithIntArg.class)
&annotationWrapper(annotations.WithNamedArg.class)
&annotationWrapper(annotations.WithArrayArg.class)
&annotationWrapper(annotations.WithEnumArg.class)
&annotationWrapper(annotations.Complex.class)


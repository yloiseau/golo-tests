package annotations;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
public @interface WithNamedArg {
  int a();
  String b() default "answer";
  // Class<?> c() default String.class;
}

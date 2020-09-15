package annotations;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
public @interface WithEnumArg {
  Values val();
}



package test;

import java.util.*;

public class OverloadedMethod {

  public String foo(String s) {
    return "String: " + s;
  }

  public String foo(Integer i) {
    return "Integer: " + i;
  }


  public String foo(Number n) {
    return "Number: " + n;
  }

  public String foo(Wrapper w) {
    return "Wrapper: " + w.toString();
  }
}

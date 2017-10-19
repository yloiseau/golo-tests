
package test;

import java.util.*;
import java.util.function.*;
import gololang.FunctionReference;

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

  public String foo(Function<String, String> f) {
    return "FunctionalInterface: " + f.apply("v");
  }

  public String foo(Predicate<String> f) {
    return "Predicate: " + f.test("v");
  }

  public String foo(FunctionReference f) throws Throwable {
    return "FunctionReference: " + f.invoke("v");
  }

  public static Function<String, String> fi(String s) {
    return (v) -> s + v;
  }

  public static Predicate<String> pred() {
    return (v) -> v.startsWith("v");
  }
}

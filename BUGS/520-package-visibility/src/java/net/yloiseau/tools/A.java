
package net.yloiseau.tools;

public class A {
  private final int answer;

  A(int v) { this.answer = v; }

  public static A of(int v) { return new A(v); }

  public int answer() { return this.answer; }

  String meth() { return "A.meth"; }

  static String fun() { return "A.fun"; }
}

package test;

public class Wrapper {
  private String v;

  @Override
  public String toString() {
    return v;
  }

  public static Wrapper of(String v) {
    Wrapper w = new Wrapper();
    w.v = v;
    return w;
  }
}


import java.util.*;

class Test {

  private static String mergeImportAndCall(String importName, String functionName) {
    if (importName == null || importName.isEmpty()) {
      return functionName;
    }
    String[] importParts = importName.split("\\.");
    String[] functionParts = functionName.split("\\.");
    StringBuilder merged = new StringBuilder();
    int fidx = 0;
    for (String imp : importParts) {
      if (imp.equals(functionParts[fidx])) {
        fidx++;
      } else if (fidx > 0) {
        return importName + '.' + functionName;
      }
      merged.append(imp).append('.');
    }
    while (fidx < functionParts.length - 1) {
      merged.append(functionParts[fidx]).append('.');
      fidx++;
    }
    merged.append(functionParts[fidx]);
    return merged.toString();
  }

  public static void main(String[] args) {
    String[] is = {"", "a.b.c", "a.b", "a"};
    String[] fs = {"a.b.c.d", "b.c.d", "c.d", "d"};
    String[] results = {
      "a.b.c.d",
      "b.c.d",
      "c.d",
      "d",
      "a.b.c.d",
      "a.b.c.d",
      "a.b.c.d",
      "a.b.c.d",
      "a.b.c.d",
      "a.b.c.d",
      "a.b.c.d",
      "a.b.d",
      "a.b.c.d",
      "a.b.c.d",
      "a.c.d",
      "a.d"
    };

    int r = 0;
    for (int i = 0; i < is.length; i++) {
      for (int f = 0; f < fs.length; f++) {
        System.out.println(mergeImportAndCall(is[i], fs[f]).equals(results[r]));
        r++;
      }
    }
    System.out.println(mergeImportAndCall("a.b.c", "e.c.d").equals("a.b.c.e.c.d"));
    System.out.println(mergeImportAndCall("a.b.c", "b.e.d").equals("a.b.c.b.e.d"));
  }
}

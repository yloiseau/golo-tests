

types: les énumérations, les annotations, le type Class ou tableau de ceux-ci

valeur par default

@Target({ElementType.METHOD, ElementType.CONSTRUCTOR })
public @interface MonAnnotation {
  public enum Niveau {DEBUTANT, CONFIRME, EXPERT} ;
  String arg1() default "";
  String[] arg2();
  String arg3();
  Niveau niveau() default Niveau.DEBUTANT;
 
}




- [x] on both
- [x] without target
- [x] pile d'annotation simples
- [x] pile d'annotation sur plusieurs toplevels
- [x] sur plusieurs toplevels sans arguments
- [x] with 1 argument simple
- [x] with named simple arguments
- [x] sur plusieurs toplevels avec argument simple
- [x] valeurs par défaut
- [ ] with 1 complex argument (enum, array)
- [ ] with named complex arguments (enum, array)
- [ ] sur plusieurs toplevels avec arguments nommés

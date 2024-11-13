import Init.Data.List

#print List.Mem

inductive Satisfies {α : Type} : α -> (α -> Prop) -> Type
  | mk : (a : α) -> (p : α -> Prop) -> p a -> Satisfies a p

inductive All {α : Type} (l : List α) : (α -> Prop) -> Type
  | mk : (a : α) -> (p: α -> Prop) -> List.Mem a l -> Satisfies a p -> All l p

inductive PropSingleton : Prop -> Type
  | mk : (p : Prop) -> PropSingleton p

example : (a : Char) -> List.Mem a "testing".toList -> PropSingleton a.isAlphanum :=
  fun c =>
  fun mem => by
  rw [String.toList] at mem
  simp only [↓Char.isValue] at mem



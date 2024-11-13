import Lean.Data

#check Lean.AssocList

inductive Path : Nat -> Type
  | start : Path 0
  | next : (prefix' : Path n) -> String -> Path n.succ

def BasicNixTypes := [String, Nat, Int]


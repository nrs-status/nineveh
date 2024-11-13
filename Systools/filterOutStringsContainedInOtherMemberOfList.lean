import Init.Data.List.Basic
import Mathlib.Data.List.Infix


inductive NonemptyList (α : Type)
  | cons : α -> List α -> NonemptyList α

def filterOutNonmaximalWrtInclusion : NonemptyList String -> List String 
  | .cons a l => let rec singleUpDownPass (la accum : List String) (reversing : Bool) : List String :=
    match la with
    | x :: [] => x :: accum
    | x :: xs => if List.any xs (fun y => decide $ x.toList.IsInfix y.toList) 
                then singleUpDownPass xs accum .false
                else
                  if reversing
                  then singleUpDownPass xs (x :: accum) .false
                  else singleUpDownPass (x :: xs) accum .true
    | [] => []
  let rec processList (l' : List String) (fuel : Nat) := 
    match fuel with
    | .succ n => processList (singleUpDownPass l' [] .false) n
    | .zero => l'
  processList (a :: l) (a :: l).length




    




#eval! filterOutNonmaximalWrtInclusion $ .cons "hello" ["unrelated", "hello", "hello/world", "hello"] 
                                                             

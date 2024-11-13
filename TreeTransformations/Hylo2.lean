import Mathlib.Util.CompileInductive

def recToIm : Bool -> Nat
  | .true => 1
  | .false => 0

def boolRecIm := @Bool.rec (fun _ => Nat) (0 : Nat) (1 : Nat)
#reduce boolRecIm .true
#reduce boolRecIm .false




def recursorToImitate : List Nat -> Nat
  | x :: xs => x + recursorToImitate xs
  | [] => 0


def recursorImitation := @List.rec Nat (fun _ => Nat) (0 : Nat) (fun head tail tailapp => head + tailapp)
#reduce recursorImitation []
#reduce recursorImitation [1, 2, 7]


def recImit2 : List Nat -> Nat := List.rec (0 : Nat) (fun head _ tailapp => head + tailapp)

def abstractImit1 := @List.rec Nat (fun _ => Nat)
def abstractImit2 := fun zeroElim succElim => @List.rec Nat (fun _ => Nat) zeroElim succElim


#check List.casesOn

def imitAsCasesOn1 := fun t => @List.casesOn Nat (fun _ => Nat) t 0 (fun head _ => head)

namespace catathinking'1 
  def fmap : (List Nat -> Nat) -> List Nat -> List Nat
    | mappate, x :: xs => mappate (x :: xs) :: fmap mappate xs
    | _, _ => []

  partial def cata : (List Nat -> Nat) -> List Nat -> Nat
    | alg => alg ∘ (fmap $ cata alg) 
  
  partial def gcata {F : Type -> Type} (α : Type) : (F α -> α) -> F α -> α := sorry

  inductive recursiveSquare (α : Type)
    | node : recursiveSquare α -> recursiveSquare α -> recursiveSquare α
    | leaf : α -> recursiveSquare α

  def recsqAlg : recursiveSquare Nat -> Nat
    | .node (.leaf n) (.leaf m) => n + m
    | .leaf n => n
    | _ => 0

  def someCoalg : Nat -> List Nat
    | .zero => [0]
    | n => [n]

  partial def anaForThisCase : (Nat -> List Nat) -> Nat -> List Nat
    | _, .zero => []
    | coalg, .succ n => coalg n ++ anaForThisCase coalg n

  #eval anaForThisCase someCoalg 5


end catathinking'1




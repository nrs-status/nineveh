


def keepWhile : (α -> Bool) -> List α -> List α
  | p, larg => 
    let rec accumulator (l accum : List α) :=
    match l with
    | y :: ys => if p y then accumulator ys (y :: accum) else accumulator ys accum
    | [] => accum
    accumulator larg [] |> List.reverse

#eval keepWhile (fun n => n ≠ 7) [5, 7, 2,8, 7, 1,8, 1]

inductive Tree (α β : Type)
  | empty : Tree α β
  | node : α -> β -> β -> Tree α β


-- tests
namespace hidden
  def CoAlgebra (F : Type -> Type) (α : Type) := α -> F α 
  def Algebra (F : Type -> Type) (α : Type) := F α -> α 
  def fmap (F : Type -> Type) (α: Type) := (α -> α ) ->  F α -> F α 

  def partition : CoAlgebra (fun t => Tree Nat t) (List Nat)
    | x :: xs => .node x (keepWhile (fun n => n < x) xs) (keepWhile (fun n => n ≥ x) xs)
    | [] => .empty

  def combine : Algebra (Tree Nat) (List Nat)
    | .node a b bb => b ++ [a] ++ bb
    | .empty => .nil

  variable (alg : Algebra (Tree Nat) (List Nat))
  variable (coalg : CoAlgebra (fun t => Tree Nat t) (List Nat))
  variable (fmap : (List Nat -> List Nat) -> Tree Nat (List Nat) -> Tree Nat (List Nat))
  variable (topfunc : List Nat -> List Nat)
  variable (ln : List Nat)
  #check coalg ln
  #check fmap topfunc $ coalg ln
  #check (fmap topfunc) ∘ coalg
  #check alg ∘ (fmap topfunc) ∘ coalg
end hidden

def CoAlgebra (F : Type -> Type) (α : Type) := α -> F α 
def Algebra (F : Type -> Type) (α : Type) := F α -> α 
def fmap (F : Type -> Type) (α: Type) := (α -> α ) ->  F α -> F α 

partial def hylo : Algebra F α -> fmap F α -> CoAlgebra F α -> α -> α 
| alg, fmapInst, coalg => alg ∘ (fmapInst (hylo alg fmapInst coalg)) ∘ coalg 

def partition : CoAlgebra (fun t => Tree Nat t) (List Nat)
  | x :: xs => .node x (keepWhile (fun n => n < x) xs) (keepWhile (fun n => n ≥ x) xs)
  | [] => .empty

def combine : Algebra (fun t => Tree Nat t) (List Nat)
  | .node a b bb => b ++ [a] ++ bb
  | .empty => .nil

partial def deleteRepeatsAfterFirst : List Nat -> List Nat
  | .cons n ln => .cons n $ deleteRepeatsAfterFirst $ (keepWhile (fun n' => n' ≠ n)) ln
  | .nil => .nil


def extendAlgebra : Algebra F α -> (α -> α) -> Algebra F α 
  | alg, extension => extension ∘ alg

def combineUnique : Algebra (Tree Nat) (List Nat) := extendAlgebra combine deleteRepeatsAfterFirst

def treefmap : fmap (Tree Nat) (List Nat)
  | f, .node a b bb => .node a (f b) (f bb)
  | _, _ => .empty


partial def qsort := hylo combine treefmap partition
partial def qsortUnique := hylo combineUnique treefmap partition

def takeN : Nat -> List Nat -> List Nat
  | .succ nn, x :: xs => x :: takeN nn xs
  | .zero, l => l
  | _, [] => []

def splitAt : Nat -> List Nat -> List Nat × List Nat
  | .succ nn, l => (takeN (.succ nn) l, takeN nn l.reverse)
  | .zero, l => ([], l)

def mergeSortedNoobVersion : List Nat -> List Nat -> List Nat
  | la, lb => qsort (la ++ lb)

def mkComparisonAlg (caselt caseeq casegt : Nat -> List Nat -> Nat -> List Nat -> List Nat) : Algebra (fun t => t × t) (List Nat)
  | ⟨x :: xs, y :: ys ⟩ => match compare x y with
                           | .lt => caselt x xs y ys
                           | .eq => caseeq x xs y ys
                           | .gt => casegt x xs y ys
  | .mk .nil l => l
  | .mk l .nil => l 

def mergeSortedAlg := mkComparisonAlg 
                           (fun l xs h ys => l :: h :: xs ++ ys)
                           (fun eqa xs eqb ys => eqa :: eqb :: xs ++ ys)
                           (fun h xs l ys => h :: l :: ys ++ xs)

  
namespace catathinking
  variable (alg : Algebra (Tree Nat) (List Nat))
  variable (catafunc : Tree Nat α -> α)
  inductive oneTwoSum (α : Type 0) (β : Type 1)
  | inl : α -> oneTwoSum α β 
  | inr : β -> oneTwoSum α β 
  #check PSum (Tree Nat (List Nat)) (Tree Nat)
  #check PSum (Tree Nat) (List Nat)
  #check Sum (fun t => Tree Nat t) (List Nat)
  #check Tree Nat
  #check oneTwoSum (List Nat) (Tree Nat)
  inductive BespokeSum (α : Type 0) (β : Type -> Type)
  | inl : α -> BespokeSum α β
  | inr : β -> BespokeSum α β

  #check (Type -> Type) -> (Type -> Type)
  def newfmap : (Type -> Type) -> (Type -> Type)
  | treenat => _
  
  def fmap2 (F : Type -> Type) (α : Type) := (F α -> α) -> F (F α) -> F α
  def testfmap : fmap2 (Tree Nat) (List Nat)
  | f, .node a b bb => f (.node a (testfmap f b) (testfmap f bb))
  | _, .empty => .empty
  def mytree : Tree Nat (List Nat) := .node 5 [2,3] [5,7]
  #check fmap2 combine

  def cata : Algebra F α -> fmap2 F α -> F α -> α
    | alg, f => alg ∘ (cata alg f)

  def sum : List Nat -> Nat
  | x :: xs => x + sum xs
  | [] => 0

  def takeHead : List Nat -> Nat
  | x :: xs => x
  | [] => 0

  def sumcata : List Nat -> Nat
  | x :: xs => takeHead (x :: xs) + sumcata xs
  | [] => 0
end catathinking

namespace catamorphismthinking2
  inductive constructorSingleton (α : Type) (F : Type -> Type) : α -> F α -> F α -> Type
  | mk : (n : α) -> (la lb : F α) -> constructorSingleton α F n la lb

  def constructorSingleton.toTree : constructorSingleton Nat List n la lb -> Tree Nat (List Nat)
  | .mk _ _ _ => .node n la lb


  #check Nat.recOn
  #check List.recOn
  #check Tree.recOn

  inductive TriType
  | one | two | three
  #check TriType.recOn


  inductive Tree' (α : Type) (F : Type -> Type)
  | empty | node : α -> F α -> F α -> Tree' α F 

  #check Tree'.recOn
  #check Tree' Nat (Tree' Nat)

  #check (fun t => Tree' t)
  def recTest := (fun t => Tree' t recTest)
  #check (fun t => List t)

  inductive Treex (α : Type) (F : Type -> Type)
  | leaf : α -> F α -> F α -> Treex α F
  | node : α -> Treex α F -> Treex α F -> Treex α F

  def cataalg : Treex Nat List -> List Nat 
  | .leaf a fa faa => fa ++ [a] ++ faa
  | .node .. => []

  def catamorphism : Treex Nat List -> List Nat 
  | .node a ta taa => 
    let recta := catamorphism ta
    let rectaa := catamorphism taa
    catamorphism $ .leaf a recta rectaa
  | leaf => cataalg leaf


end catamorphismthinking2

namespace catamorphismthinking3
  inductive Treexx (α : Type) (F : Type -> Type)
    | empty | leaf : α -> F α -> F α -> Treexx α F

  inductive Tree' (α : Type) (F : Type -> Type)
    | leaf : F α -> Tree' α F
    | node : α -> Tree' α F -> Tree' α F -> Tree' α F



  def cataalg : Tree' Nat List -> List Nat
  | .leaf fa => fa
  | .node a (.leaf fa) (.leaf faa) => fa ++ [a] ++ faa
  | _ => []

  partial def cata (t : Tree' Nat List) : List Nat :=
   match t with
    | .leaf .. => cataalg t
    | .node a (.leaf ..) (.leaf ..) => cataalg t
    | .node a na nb => 
      let na' := cata na
      let nb' := cata nb
      cata (.node a (.leaf na') (.leaf nb'))

end catamorphismthinking3

namespace anamorphismthinking
  inductive Tree' (α : Type) (F : Type -> Type)
  | leaf : F α -> Tree' α F
  | node : α -> Tree' α F -> Tree' α F -> Tree' α F

  def anacoalg : List Nat -> Tree' Nat List
  | x :: xs => .node x (.leaf $ keepWhile (fun n => n < x) xs) (.leaf $ keepWhile (fun n => n ≥ x) xs)
  | [] => .leaf []

  instance : Inhabited $ Tree' Nat List where
    default := .leaf []

  partial def ana (l : List Nat) : Tree' Nat List :=
  match anacoalg l with
    | .node x (.leaf la) (.leaf lb) => .node x (ana la) (ana lb)
    | _ => .leaf []

  partial def ana2 : List Nat -> (List Nat -> Tree' Nat List) -> Tree' Nat List
  | l, coalg => match coalg l with
    | .node x (.leaf la) (.leaf lb) => .node x (ana2 la coalg) (ana2 lb coalg)
    | _ => .leaf []
    
  def anafmap (F : Type -> Type) (α : Type) := (α -> F α) -> F α -> F α
  def anafmap2 : (List Nat -> Tree' Nat List) -> Tree' Nat List -> Tree' Nat List
    | f, .node x (.leaf la) (.leaf lb) => .node x (f la) (f lb)
    | _, _ => .leaf []

  #check List Nat -> Tree' Nat List
  #check Tree' Nat
  #check List
  #check (fun t => List t)
  #check Tree'
  #check Tree' Nat (fun t => List t)
  -- λ ? (List) (Nat) == List Nat -> Tree' Nat List?
  #print Tree'
  #reduce (types := true) (fun (T : Type -> Type) => fun (α : Type) => T α -> Tree' α T) (fun t => List t) Nat
  def trueAnafmap 
end anamorphismthinking

namespace anamorphismthinking2
  def Tree := anamorphismthinking.Tree'

  def anafmap' (F : Type -> Type) (α : Type) (repa : Type -> (Type -> Type) -> Type) := sorry
  def anafmapx (F : Type -> Type) (α : Type) (coalg : α -> F α) := F α -> F α
  def ana (F : Type -> Type ) (α : Type) : (α -> F α) -> α -> F α
  | coalg, fmap => fmap (ana F α coalg fmap) ∘ coalg

  def anafmap (F : Type -> Type) (α : Type) := (α -> F α ) -> F α -> F α
  partial def ana2 (F : Type -> Type) (α : Type) : (α -> F α) -> anafmap F α -> α -> F α
    | coalg, fmap => fmap (ana2 F α coalg fmap) ∘ coalg 
end anamorphismthinking2

namespace anamorphismthinking3
  def Tree := anamorphismthinking.Tree'
  #print anamorphismthinking.Tree'

  def CoAlgFmap (F : Type -> Type) (α : Type) := CoAlgebra F α -> F α -> F α

  instance : Inhabited $ CoAlgebra (Tree Nat) (List Nat) -> CoAlgFmap (Tree Nat) (List Nat)

  partial def anamorphism : CoAlgebra F α -> CoAlgFmap F α -> α -> F α
    | coalg, fmap => fmap (anamorphism coalg fmap) ∘ coalg

end anamorphismthinking3

def mylist := [3,2,7,1,1,2]
#eval qsort mylist
#eval qsortUnique mylist
#eval deleteRepeatsAfterFirst $ qsort [3,2,7,1,1,2]

#eval [1, 8].head (by simp)

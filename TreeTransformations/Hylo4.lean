
def keepWhile : (α -> Bool) -> List α -> List α 
  | p, larg => 
    let rec accumulator (l accum : List α) :=
      match l with
      | y :: ys => if p y then accumulator ys (y :: accum) else accumulator ys accum
      | [] => accum
    accumulator larg [] |> List.reverse

inductive Tree (α : Type)
  | nil | node : α -> Tree α -> Tree α -> Tree α

def partition : List Nat -> (Nat × List Nat × List Nat) ⊕ Unit
  | x :: xs => .inl ⟨x, (keepWhile (fun n => n < x) xs), (keepWhile (fun n => n ≥ x) xs)⟩
  | [] => .inr .unit

def combine : (Nat × List Nat × List Nat) ⊕ Unit -> List Nat
  | .inr .. => []
  | .inl ⟨n, la, lb⟩ => la ++ [n] ++ lb

def Organizer (α : Type) := (α × List α × List α) ⊕ Unit

partial def hylo : (Organizer Nat -> List Nat) -> (List Nat -> Organizer Nat) -> List Nat -> List Nat
  | alg, coalg, l => match coalg l with
    | .inr .. => []
    | .inl ⟨n, la, lb⟩ => alg $ .inl ⟨n, hylo alg coalg la, hylo alg coalg lb⟩

/- in Lean, the signatures are as simple as 
cata : F α -> α
ana : α -> F α
hylo : (F α -> α) -> (α -> F α) -> α -> α
where, as seen above, hylo gives the fmap in itself, not through requiring something else
-/


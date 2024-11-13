
inductive List' (α : Type)
| nil | cons : α -> List' α -> List' α

#print List.map
#print List.brecOn

def List'.map : List' α -> (α -> β) -> List' β 
  | .cons x xs, f => .cons (f x) $ List'.map xs f
  | .nil, _ => .nil

instance : Functor List' where
  map f l := List'.map l f


--

inductive Tree (α β : Type)
| node : α -> Tree α β -> Tree α β -> Tree α β 
| leaf : α -> β -> β -> Tree α β


-- it turns out that this map does not satisfy functor laws
def Tree.map' : Tree α β -> (α ⊕ β -> γ) -> Tree γ γ
  | .node a ta taa, f => .node (f (.inl a)) (ta.map' f) (taa.map' f)
  | .leaf a b bb, f => .leaf (f $ .inl a) (f $ .inr b) (f $ .inr bb)

inductive Tree' (α : Type)
  | nil | node : α -> Tree' α -> Tree' α -> Tree' α 

def fmapOf (F : Type -> Type) := {α β : Type} -> (α -> β) -> F α -> F β

def Tree'.map : (α -> β) -> Tree' α -> Tree' β
  | _, .nil => .nil
  | f, .node a ta taa => .node (f a) (ta.map f) (taa.map f)

def Tree'.algOf (α : Type) := Tree' α -> α



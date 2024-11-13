inductive WType {α : Type} (β : α → Type)
  | mk (a : α) (f : β a → WType β) : WType β



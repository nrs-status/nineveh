
def keepWhile : (p : α -> Prop) -> [DecidablePred p] -> List α -> List α
  | p, _, larg =>
    let rec accumulator (l accum : List α) :=
    match l with 
    | y :: ys => if p y then accumulator ys (y :: accum) else accumulator ys accum
    | [] => accum
    accumulator larg [] |> List.reverse

def takeWhile : (p : α -> Prop) -> [DecidablePred p] -> List α -> List α 
  | p, _, larg => match larg with
    | x :: xs => if p x then x :: (takeWhile p xs) else []
    | [] => []

def splitAfterWhen : (p : α -> Prop) -> [DecidablePred p] -> List α -> List α × List α
  | p, _, larg => 
    let rec accumulator (l accum : List α) :=
    match l with
    | x :: xs => if p x then (x :: accum, xs) else accumulator xs (x :: accum)
    | [] => ([], [])
    accumulator larg [] |> fun | ⟨l, r⟩ => ⟨l |> List.reverse, r ⟩ 

#eval splitAfterWhen (fun n => n = 10) [1, 2, 10, 4, 7, 5, 5]

partial def splitAfterEverywhereWhere : (p : α -> Prop) -> [DecidablePred p] -> List α -> List (List α)
  | _, _, [] => []
  | p, _, larg => splitAfterWhen p larg |> fun | ⟨l, r⟩ => l :: splitAfterEverywhereWhere p r

def stdinInputAsListOfLines (stdinInput : ByteArray) : List String :=
  stdinInput 
  |> ByteArray.toList 
  |> splitAfterEverywhereWhere (fun n => n = 10)
  |> List.map (List.filter (fun uint => uint != '\n'.val.toUInt8)
               |> (List.toByteArray ∘ ·)
               |> (String.fromUTF8! ∘ ·))

def myfun : List (List UInt8) -> List String := 
  List.map $ Id.run do let x <- List.filter (fun uint => uint != '\n'.val.toUInt8)
                       let y <- (List.toByteArray ∘ x)
                       (String.fromUTF8! ∘ y)

def idrun : Id Nat := 2 >>= (fun n => n + n)
def idrun2 : Id Nat := 2 >>= fun () => 5
def idrun' := Id.run do let x <- 2; fun (n : Nat) => n + n
#check (fun f => f ∘ .) List.toByteArray
def idrun3f : List ByteArray := Id.run do (fun f => (f ∘ .)) List.toByteArray


#check Bind.bind
#check fun x => List.toByteArray ∘ x
#check fun x => String.fromUTF8! ∘ x


#check MonadReaderOf

def Reader (ρ : Type) (α : Type) : Type := ρ -> α 
def read : Reader ρ ρ := fun env => env
def Reader.pure (x : α ) : Reader ρ α := fun _ => x
def Reader.bind (result : Reader ρ α) (next : α -> Reader ρ β) : Reader ρ β :=
  fun env => next (result env) env

instance : Monad (Reader ρ) where
  pure x := fun _ => x
  bind x f := fun env => f (x env) env

def reader1 : Reader (List UInt8) ByteArray :=
  read >>= fun env => pure env.toByteArray

def reader2 : Reader (List UInt8) ByteArray := do 
  let x <- read
  pure x.toByteArray

#check Prod.casesOn
#check MonadReaderOf.mk
#check MonadReader.mk
#check MonadReader.mk (m := fun (n : Nat) => n) (4 : Nat)
#check @MonadReader.mk Nat (fun n => n + n) 4
#check @MonadReaderOf.mk Nat (fun _ => Nat) 5
#check MonadReader.mk 6
#check (MonadReader.mk 7 : MonadReader Nat (fun _ => Nat))


def reader3 := @MonadReader.mk Nat (fun _ => Nat) 5
#eval reader3.read

#check readThe
#check readThe (7 : Nat)

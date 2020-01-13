
let razlika_kvadratov a b = (a+b)*(a+b) - (a*a + b*b) 

let uporabi_na_paru f x y = (f x, f y)

let rec ponovi_seznam n sez = 
     if  n <= 0 then []
     else sez @ ponovi_seznam (n-1) sez

let ponovi_seznam_tlrec n sez =
    let rec ponovi acc n =
        if n <= 0 then acc else ponovi (acc@sez) (n-1)
    in
    ponovi [] n

let rec razdeli sez = 
    let rec deli n_acc p_acc = function
    | [] -> (List.rev n_acc,List.rev p_acc)
    | x :: xs when x < 0 -> deli (x :: n_acc) p_acc xs
    | x :: xs -> deli n_acc (x::p_acc) xs 
    in
    deli [] [] sez

(* 2. naloga*)





(* 3. naloga*)

type  'a veriga =
    | Filter of ('a -> bool) * 'a list * 'a veriga 
    | Ostalo of 'a list

let test = Filter ((>) 0, [], Filter ((>) 10, [], Ostalo []))

let rec vstavi x = function
    |Filter (f, ys, rest) when f x -> Filter (f, x::ys, rest)
    |Filter (f, ys, rest) -> Filter (f, ys, vstavi x rest)
    |Ostalo ys -> Ostalo (x :: ys)

let test2 = List.fold_right vstavi [-5;7;100;-7;2] test

let rec poisci x = function
    |Filter (f, ys, rest) when f x -> List.mem x ys
    |Filter (f, ys, rest) -> poisci x rest
    |Ostalo ys -> List.mem x ys

let rec izprazni_filtre = function
    |Filter (f,ys,rest) -> 
        let (empty_rest, elementi) = izprazni_filtre rest in
        (Filter(f, [], empty_rest), ys @ elementi)
    |Ostalo ys -> (Ostalo [], ys)

let rec dodaj_filter f rest = 
    let (empty_rest, elements) = izprazni_filtre rest in
    let filters = Filter (f, [], empty_rest) in
    List.fold_left (fun fil x -> vstavi x fil) filters elements
         



 


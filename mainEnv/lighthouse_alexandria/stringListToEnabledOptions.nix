{ ... }:
let
	optionNameToAttrSetToPreprocess = optionName: { name = optionName; value = { enable = true; }; }; 
in
listOfOptionNames: builtins.listToAttrs (map (x: optionNameToAttrSetToPreprocess x) listOfOptionNames)


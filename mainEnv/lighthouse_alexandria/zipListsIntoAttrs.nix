{lib, ...}: let
  makePairsForBuildingAttrSet = list1: list2:
    lib.zipListsWith (a: b: {
      name = a;
      value = b;
    })
    list1
    list2;
in
  list1: list2: lib.listToAttrs (makePairsForBuildingAttrSet list1 list2)

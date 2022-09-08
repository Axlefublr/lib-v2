;No dependencies

StrDefineProp := Object().DefineProp

StrDefineProp("".base, "Length", {Get: StrLen})

StrDefineProp("".base, "toTitle", {Call: StrTitle})
StrDefineProp("".base, "toLower", {Call: StrLower})
StrDefineProp("".base, "toUpper", {Call: StrUpper})

;Required for the ide to recognize the new string methods and properties, doesn't actually do anything
Class axle_String {

   static toTitle() => this

   static toLower() => this

   static toUpper() => this

}
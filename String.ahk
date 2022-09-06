;No dependencies

PrimDefineProp := Object().DefineProp

;StrLen("string") => "string".Length
PrimDefineProp("".base, "Length", {Get: StrLen})
#I "tools/FAKE/tools"
#r "tools/FAKE/tools/FakeLib.dll"

open Fake

printfn "Restoring packages"
RestorePackages()
printfn "Restored packages"


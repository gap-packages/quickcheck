#
# QuickCheck: Randomised Testing for GAP Functions
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2026.03.17") then
    Error("AutoDoc version 2026.03.17 or newer is required.");
fi;

AutoDoc( rec( scaffold := true, autodoc := true, extract_examples := true ) );

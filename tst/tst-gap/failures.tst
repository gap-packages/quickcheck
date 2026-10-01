gap> START_TEST("failures.tst");

# Either function in QC_CheckEqual may skip
gap> skipZero := function(x) if x = 0 then return QC_Skip; fi; return x; end;;
gap> QC_CheckEqual([IsInt], skipZero, x -> x);
true
gap> QC_CheckEqual([IsInt], x -> x, skipZero);
true
gap> QC_CheckEqual([IsInt], x -> 1, function(x) end, rec(tests := 5));
Test 0 of 5 failed:
 Input: [ 0 ]
 Output: At least one function did not return a value
false

#
gap> STOP_TEST("failures.tst", 1);

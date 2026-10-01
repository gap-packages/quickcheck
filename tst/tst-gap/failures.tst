gap> START_TEST("failures.tst");

# Either function in QC_CheckEqual may skip
gap> skipZero := function(x) if x = 0 then return QC_Skip; fi; return x; end;;
gap> QC_CheckEqual([IsInt], skipZero, x -> x);
true
gap> QC_CheckEqual([IsInt], x -> x, skipZero);
true
gap> QC_Check([IsInt], x -> "SKIP TEST", rec(tests := 5));
Test 0 of 5 failed:
 Input: [ 0 ]
 Output: SKIP TEST
false
gap> QC_Skip;
QC_Skip
gap> QC_CheckEqual([IsInt], x -> 1, function(x) end, rec(tests := 5));
Test 0 of 5 failed:
 Input: [ 0 ]
 Output: At least one function did not return a value
false

# Generators only use the given random source
gap> rs := RandomSource(IsMersenneTwister, 3);;
gap> a := QC_ListOf(IsInt)(rs, 9);; b := QC_SetOf(IsInt)(rs, 9);;
gap> Reset(GlobalMersenneTwister, 77);; Random([1..10]);;
gap> rs := RandomSource(IsMersenneTwister, 3);;
gap> a = QC_ListOf(IsInt)(rs, 9);
true
gap> b = QC_SetOf(IsInt)(rs, 9);
true

# QC_LastFailure records the unmodified arguments of the last failure
gap> f := function(l) Add(l, 1000); return Length(l) < 5; end;;
gap> QC_Check([QC_ListOf(IsPosInt)], f);
Test 90 of 500 failed:
 Input: [ [ 1, 4, 3, 3 ] ]
 Output: false
false
gap> QC_LastFailure().args;
[ [ 1, 4, 3, 3 ] ]
gap> QC_LastFailure().func = f;
true
gap> QC_RerunLastFailure();
false
gap> QC_LastFailure().args;
[ [ 1, 4, 3, 3 ] ]

# Every check clears it, including passing ones and those with too many skips
gap> QC_Check([IsInt], x -> true);
true
gap> QC_LastFailure();
false
gap> QC_RerunLastFailure();
fail
gap> QC_Check([QC_ListOf(IsPosInt)], f);;
Test 90 of 500 failed:
 Input: [ [ 1, 4, 3, 3 ] ]
 Output: false
gap> QC_Check([IsInt], x -> QC_Skip, rec(tests := 2));
Too many tests skipped. Only managed 0 out of 2 tests
false
gap> QC_LastFailure();
false

# QC_CheckEqual records both functions
gap> sq := x -> x^2;;
gap> QC_CheckEqual([IsPosInt], IdFunc, sq);
Test 31 of 500 failed:
 Input: [ 2 ]
 Output: Return values differ: 2 and 4
false
gap> QC_LastFailure() = rec(args := [ 2 ], funcs := [ IdFunc, sq ]);
true
gap> QC_RerunLastFailure();
"Return values differ: 2 and 4"

#
gap> STOP_TEST("failures.tst", 1);

gap> START_TEST("failures.tst");

# Either function in QC_CheckEqual may skip
gap> skipZero := function(x) if x = 0 then return QC_Skip; fi; return x; end;;
gap> QC_CheckEqual([IsInt], skipZero, x -> x);
true
gap> QC_CheckEqual([IsInt], x -> x, skipZero);
true

#
gap> STOP_TEST("failures.tst", 1);

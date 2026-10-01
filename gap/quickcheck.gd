#
# QuickCheck: Randomised Testing for GAP Functions
#
#! @Chapter Introduction
#!
#! QuickCheck is a property-based testing package for GAP that automatically
#! validates functions against randomly generated inputs. The package can either
#! verify that a function consistently returns 'true' across inputs, or confirm
#! that two functions produce identical results for the same inputs.
#!
#! The strength of QuickCheck lies in its ability to rapidly test functions with
#! diverse inputs, including edge cases that are often overlooked in manual testing,
#! such as empty lists, trivial groups, or boundary values. By generating hundreds
#! of test cases automatically, QuickCheck helps discover bugs and inconsistencies
#! that might not be apparent from inspecting code or writing traditional tests.
#!
#! This approach is particularly valuable for mathematical algorithms and group
#! theory implementations where exhaustive testing is impractical.
#!
#! @Chapter Tutorial
#!
#! @Chapter Functionality
#!
#!
#! @Section Methods
#!
#! This section will describe the methods of QuickCheck


#! @Description
#! Create a random object as described by
#! <A>ObjectDescription</A> of size at most <A>limit</A>
#! using <A>RandomSource</A>. How <A>limit</A> is interpreted
#! will vary depending on the type of object.
#! @Arguments ObjectDescription, RandomSource, limit
DeclareGlobalFunction("QC_MakeRandomArgument");


#! @Description
#! Run tests on <A>function</A> with arguments as described
#! in <A>arguments</A>.
#! @Arguments arguments, function[, config]
DeclareGlobalFunction("QC_Check");

#! @Description
#! Check that, given the same list of arguments as described in <A>arguments</A>,
#! functionL and function return the same value.
#! @Arguments arguments, functionL, functionR[, config]
DeclareGlobalFunction("QC_CheckEqual");

#! @Description
#! Return the function called, and arguments given, if the most recent call to
#! `QC_Check` or `QC_CheckEqual` failed on a particular input.
#!
#! Returns a record containing <A>args</A> (the arguments) and a function `func`
#! (if `QC_Check` failed) or a list of functions `funcs` (if `QC_CheckEqual` failed).
#! Returns <K>false</K> otherwise.
DeclareGlobalFunction("QC_LastFailure");


#! @Description
#! Rerun the last test which failed, as given by <Ref Func="QC_LastFailure"/>.
#! This is most useful if a test in a '.tst' file failed, as this will allow the
#! test to enter the break loop. Returns <K>fail</K> if <Ref Func="QC_LastFailure"/>
#! returns <K>false</K>.
DeclareGlobalFunction("QC_RerunLastFailure");

#! @Description
#! Set config options for QuickCheck globally, by passing a record. It is not required
#! to set all options.
#!
#! Current options are:
#!  * <C>tests</C>: Number of tests to run
#!  * <C>limit</C>: The size of the largest object to create
#!  * <C>seed</C>: Initial random seed
#!
#! @Arguments config
DeclareGlobalFunction("QC_SetConfig");


#! @Description
#! Get the current global configuration for QuickCheck, as a record
DeclareGlobalFunction("QC_GetConfig");


# A unique object, compared with IsIdenticalObj
DeclareCategory("IsQCSkip", IsObject);
BindGlobal("QC_Skip", Objectify(NewType(NewFamily("QCSkipFamily"), IsQCSkip and IsPositionalObjectRep), []));
DeclareGlobalFunction("QC_RegisterFilterGen");
DeclareGlobalFunction("QC_ListOf");
DeclareGlobalFunction("QC_FixedLengthListOf");
DeclareGlobalFunction("QC_PairOf");
DeclareGlobalFunction("QC_SetOf");
DeclareGlobalFunction("QC_ElementOf");

## For private data
BindGlobal("_QC", rec());

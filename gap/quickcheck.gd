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


DeclareCategory("IsQCSkip", IsObject);

#! @Description
#! A function tested by <Ref Func="QC_Check"/> or <Ref Func="QC_CheckEqual"/>
#! can return <C>QC_Skip</C> if its arguments do not satisfy its requirements
#! (for example, if it needs an intransitive group, or an integer which is not prime).
#! Skipped tests do not count as failures or towards the number of tests.
#! To avoid infinite loops, if 100 times the requested number of tests
#! are skipped, the check stops and returns <K>false</K>.
DeclareGlobalName("QC_Skip");

#! @Description
#! Register <A>gen</A> as a generator for arguments described by the filter
#! <A>filter</A>. <A>gen</A> is called as <C>gen(rs, limit)</C>, where <A>rs</A> is a
#! random source and <A>limit</A> a positive integer bounding the size of the value.
#! It is up to <A>gen</A> to decide how to interpret <A>limit</A>.
#! Smaller values of <A>limit</A> are used first, so simple inputs are tested
#! before complex ones.
#! Values not in <A>filter</A> are discarded and regenerated, with an error
#! after 100 attempts. This lets a generator serve a more specific filter, for
#! example an abelian permutation group when only a <A>gen</A> for permutation
#! groups has been installed.
#! @Arguments filter, gen
DeclareGlobalFunction("QC_RegisterFilterGen");

#! @Section Argument descriptions
#!
#! An argument description is either a filter with a registered generator
#! (see <Ref Func="QC_RegisterFilterGen"/>), or a function <C>gen(rs, limit)</C>.
#! The functions below build descriptions from other descriptions.

#! @Description
#! Describes a list of between 0 and <C>limit</C> values described by <A>desc</A>.
#! @Arguments desc
#! @BeginExampleSession
#! gap> QC_Check([QC_ListOf(QC_PairOf(IsPosInt))],
#! >             l -> ForAll(l, p -> Length(p) = 2 and ForAll(p, IsPosInt)));
#! true
#! @EndExampleSession
DeclareGlobalFunction("QC_ListOf");

#! @Description
#! Describes a list of <A>len</A> values described by <A>desc</A>.
#! @Arguments desc, len
DeclareGlobalFunction("QC_FixedLengthListOf");

#! @Description
#! Describes a list of length two, whose entries are described by <A>desc</A>.
#! @Arguments desc
DeclareGlobalFunction("QC_PairOf");

#! @Description
#! Describes a set of between 0 and <C>limit</C> values described by <A>desc</A>.
#! @Arguments desc
DeclareGlobalFunction("QC_SetOf");

#! @Description
#! Describes a random element of the collection <A>coll</A>. This ignores
#! <C>limit</C>.
#! @Arguments coll
DeclareGlobalFunction("QC_ElementOf");

## For private data
BindGlobal("_QC", rec());

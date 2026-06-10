gap> LoadPackage("quickcheck", false);
true
gap> QC_Check([IsTransformation, IsTransformation, IsTransformation], {s,t,u} -> (s*t)*u = s*(t*u));
true
gap> QC_Check([IsTransformation, IsTransformation, IsPosInt], {s,t,i} -> (i^s)^t = i^(s*t));
true
gap> QC_Check([IsTransformation], {s} -> s * One(s) = s);
true
gap> QC_Check([IsTransformation], {s} -> One(s) * s = s);
true
gap> QC_Check([IsTransformation, IsTransformation], {s,t} -> RankOfTransformation(s*t, DegreeOfTransformation(s)) <= RankOfTransformation(s, DegreeOfTransformation(s)));
true
gap> QC_Check([IsTransformation, IsTransformation], {s,t} -> IsSubset(ImageSetOfTransformation(t, DegreeOfTransformation(s) + DegreeOfTransformation(t)), ImageSetOfTransformation(s*t, DegreeOfTransformation(s) + DegreeOfTransformation(t))));
true
gap> QC_Check([IsPerm], {p} -> AsTransformation(p^-1) = InverseOp(AsTransformation(p)));
true

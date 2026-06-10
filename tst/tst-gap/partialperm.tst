gap> LoadPackage("quickcheck", false);
true
gap> QC_Check([IsPartialPerm, IsPartialPerm, IsPartialPerm], {p,q,r} -> (p*q)*r = p*(q*r));
true
gap> QC_Check([IsPartialPerm], {p} -> (p^-1)^-1 = p);
true
gap> QC_Check([IsPartialPerm], {p} -> p * p^-1 * p = p);
true
gap> QC_Check([IsPartialPerm], {p} -> p^-1 * p * p^-1 = p^-1);
true
gap> QC_Check([IsPartialPerm, IsPartialPerm], {p,q} -> (p*q)^-1 = q^-1 * p^-1);
true
gap> QC_Check([IsPartialPerm], {p} -> DomainOfPartialPerm(p^-1) = ImageSetOfPartialPerm(p));
true
gap> QC_Check([IsPerm], {p} -> AsPartialPerm(p)^-1 = AsPartialPerm(p^-1));
true

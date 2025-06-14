gap> QC_CheckEqual([IsPermGroup, IsPermGroup], Intersection, {g,h} -> Group(Intersection(AsList(g), AsList(h))));
true
gap> QC_CheckEqual([IsPermGroup, IsPermGroup, IsPerm], {g,h,p} -> Intersection(g,h)^p, {g,h,p} -> Intersection(g^p, h^p));
true
gap> QC_CheckEqual([IsPermGroup, IsPermGroup, IsPermGroup], {g1, g2, g3} -> Intersection(Intersection(g1,g2),g3), {g1,g2,g3} -> Intersection(g1,Intersection(g2,g3)));
true
gap> QC_Check([IsCyclic], {g} -> IsCyclic(g));
true
gap> QC_Check([QC_ElementOf(AlternatingGroup(7))], {p} -> LargestMovedPoint(p) <= 7);
true

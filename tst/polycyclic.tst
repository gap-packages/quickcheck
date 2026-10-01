#@if TestPackageAvailability("polycyclic") <> fail
gap> LoadPackage("polycyclic", false);
true
gap> LoadPackage("quickcheck", false);
true
gap> QC_Check([IsFreeAbelian], G -> IsAbelian(G) and IsFreeAbelian(G));
true
#@fi

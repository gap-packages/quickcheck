#
# QuickCheck: Randomised Testing for GAP Functions
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "quickcheck",
Subtitle := "Randomised Testing for GAP Functions",
Version := "1.0.2",
Date := "10/06/2026", # dd/mm/yyyy format
License := "MPL-2.0",

Persons := [
  rec(
    FirstNames := "Christopher",
    LastName := "Jefferson",
    WWWHome := "https://heather.cafe/",
    Email := "caj21@st-andrews.ac.uk",
    IsAuthor := true,
    IsMaintainer := true,
    PostalAddress := "Jack Cole Building, North Haugh, St Andrews, Fife, KY16 9SX, Scotland",
    Place := "St Andrews",
    Institution := "University of St Andrews",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/gap-packages/quickcheck",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://gap-packages.github.io/quickcheck",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "quickcheck",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Randomised Testing for GAP Functions",
),

Dependencies := rec(
  GAP := ">= 4.11",
  NeededOtherPackages := [ ["polycyclic", ">=1.1"] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

Extensions := [
  rec(
    needed := [ ["digraphs", "1.0.0" ] ],
    filename := "gap/digraphs.g",
  )
],

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));



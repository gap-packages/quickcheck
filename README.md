# QuickCheck for GAP

[![CI](https://github.com/gap-packages/quickcheck/actions/workflows/CI.yml/badge.svg)](https://github.com/gap-packages/quickcheck/actions/workflows/CI.yml)

This package provides a library for randomized, property-based testing in GAP, inspired by the QuickCheck framework found in languages like Haskell.

It allows you to write tests as general properties that should hold true for your code, and the `QuickCheck` package will then generate a large number of random test cases to try and find a counterexample.

## Features

* **Property-Based Testing**: Define properties and let the framework generate test data automatically.
* **Automatic Sizing**: The package automatically tries a range of different sizes for the generated objects, starting with small and simple cases to find the minimal counterexamples first.
* **Variety of Types**: It supports random generation for a range of common GAP types.

## Adding New Types

We are happy to expand the range of types that QuickCheck can generate. If you need support for a type that is not yet implemented, please open an issue on our GitHub page, and we will look into adding it.

## Contact

For any questions, bug reports, or feature requests, please post an issue at the GitHub repository:
[https://github.com/gap-packages/quickcheck/issues](https://github.com/gap-packages/quickcheck/issues)

All code in the `QuickCheck` package, unless otherwise stated, is licensed under the Mozilla Public License 2.0

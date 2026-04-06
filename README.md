# `minitest-bonus-assertions`

[![RubyGems Version][shield-gems]][rubygems] ![Coveralls][shield-coveralls]
[![Build Status][shield-ci]][ci-workflow]

- code :: <https://github.com/halostatue/minitest-bonus-assertions>
- issues :: <https://github.com/halostatue/minitest-bonus-assertions/issues>
- changelog ::
  <https://github.com/halostatue/minitest-bonus-assertions/blob/main/CHANGELOG.md>

## Description

Bonus assertions for [Minitest][minitest], providing assertions I (used to) use
frequently, supporting only Ruby 2.0 or better.

> I have not used these regularly for tests in about ten years. They're still
> likely good, but I no longer consider them necessary.

## Features

New assertions:

- `assert_false` / `must_be_false`: requires that the value be exactly `false`.
- `assert_true` / `must_be_true`: requires that the value be exactly `true`.
- `assert_between` / `must_be_between`: requires that the value be strictly
  between the low and high values provided, or the range (this test is
  boundary-exclusive).
- `assert_has_keys` / `refute_missing_keys` / `must_have_keys`: requires that
  the object contains all of the keys expected.
- `assert_missing_keys` / `refute_has_keys` / `must_not_have_keys`: requires
  that the object _not_ have any of the keys expected.
- `assert_raises_with_message` / `must_raise_with_message`: requires that the
  exception raised in the provided block has a specific message (tested with
  `assert_equal`).
- `assert_set_equal` / `must_equal_set`: requires that the actual enumerable
  have the same values as the expected enumerable, without regard to order and
  ignoring duplicate values.
- `refute_set_equal` / `must_not_equal_set`: requires that the actual enumerable
  _not_ have the same values as the expected enumerable.
- `assert_result_equal`: requires that the actual is equal to the result of
  evaluating an expression.

I am also providing the Minitest-tester code I use as something that can be
required by other developers. This should _only_ be used to test Minitest
assertions and extensions. For more information on `Minitest::AssertionTests`,
see its documentation.

## Background

`minitest-bonus-assertions` started life as a patch to Ben Somer’s
[`minitest-extra-assertions`][extra]. There were some nice assertions included,
but there were other changes that needed to be made to bring it up to support
Minitest 5. There was also an override to the default `assert_match`
implementation meant to ease the transition from Test::Unit (the main reason he
wrote this assertion plugin for Minitest in the first place). I do not believe
this is sensible five major versions into Minitest: I removed it. Ben did not
feel comfortable making this particular change, so I felt that the best way to
provide the original assertions and my new assertions—without the `assert_match`
override—was to fork this as a new project. I am indebted to Ben and his
contributors for writing these assertions in the first place.

## `minitest-bonus-assertions` Semantic Versioning

`minitest-bonus-assertions` uses a [Semantic Versioning][semver] scheme with one
change:

- When PATCH is zero (`0`), it will be omitted from version references.

[ci-workflow]: https://github.com/halostatue/minitest-bonus-assertions/actions/workflows/ci.yml
[coveralls]: https://coveralls.io/github/halostatue/minitest-bonus-assertions?branch=main
[extra]: https://github.com/bensomers/minitest-extra-assertions
[minitest]: https://github.com/seattlerb/minitest
[rubygems]: https://rubygems.org/gems/minitest-bonus-assertions
[semver]: https://semver.org/
[shield-ci]: https://img.shields.io/github/actions/workflow/status/halostatue/minitest-bonus-assertions/ci.yml?style=for-the-badge "Build Status"
[shield-coveralls]: https://img.shields.io/coverallsCoverage/github/halostatue/minitest-bonus-assertions?style=for-the-badge
[shield-gems]: https://img.shields.io/gem/v/minitest-bonus-assertions?style=for-the-badge "Version"

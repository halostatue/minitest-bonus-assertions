# `minitest-bonus-assertions` Changelog

## 3.1.0 / 2026-04-06

- Josef Šimánek ([@simi][@simi]) fixed an improper self-dependency in
  [#3][issue-3].

- Modernized. While I have not changed most of the dependencies, I will no
  longer guarantee that this works on any version less than Ruby 3.2.

## 3.0 / 2017-04-26

- 1 major enhancement

  - Dropped support for Ruby 1.9.

- 1 minor enhancement

  - Added assertion `assert_result_equal` (expectation `must_equal_result`) to
    be ready for Minitest 6. This will allow those who have legitimate cases
    where they do not know whether the expected is nil or not to have a
    meaningful test and silence deprecation warnings.

## 2.0 / 2015-10-19

- 1 major enhancement

  - Added Minitest::AssertionTests to assist with testing newly added
    assertions, even for other gems. Previously, a variant of what is provided
    was present in `test/minitest_config.rb`.

- 2 minor enhancements

  - Made the expectation `must_be_between` ready for the next version of
    Minitest by calling `assert_between` on the test context (`ctx`) rather than
    on the bare object under test. Because of this change,
    `minitest-bonus-assertions` is now tested for compatibility only with
    `minitest` 5.8 or higher.

  - Added `assert_set_equal` and `refute_set_equal` (with expectation forms of
    `must_equal_set` and `must_not_equal_set`) to test enumerable values for set
    equality.

- 1 minor bug fix

  - The documentation for `assert_between` was unclear; it is a
    boundary-exclusive test, not a boundary-inclusive test. That is, it is
    `lo < exp < hi`, not `lo <= exp <= hi`.

- 1 governance change

  - This project now has a [Code of Conduct](CODE_OF_CONDUCT.md).

## 1.0 / 2015-03-05

- 1 major enhancement

  - Birthday!

[@simi]: https://github.com/simi
[issue-3]: https://github.com/halostatue/minitest-bonus-assertions/issues/3

##
# Use Minitest::AssertionTests to test assertions for Minitest.
#
#   describe Minitest::BonusAssertions do
#     include Minitest::AssertionTests
#
#     it 'be triggered for false or nil' do
#       assert_expected_assertions 2 do
#         assert_assertion_triggered '<true> expected but was false.' do
#           tc.assert_true false
#         end
#
#         assert_assertion_triggered '<true> expected but was nil.' do
#           tc.assert_true nil
#         end
#       end
#     end
#   end
module Minitest::AssertionTests
  # The test case to use for the assertion under test.
  attr_reader :tc
  # The test spec to use for the expectation under test.
  attr_reader :spec

  def setup # :nodoc:
    super

    Minitest::Test.reset

    @tc = Minitest::Test.new 'fake test case'
    @spec = Minitest::Spec.new 'fake test spec'
  end

  # Specify the number of assertions that should be called during the test
  # under this block. Most tests should be wrapped in this assertion.
  def assert_expected_assertions expected = 1
    yield
  ensure
    actual = tc.assertions + spec.assertions
    assert_equal expected, actual, "expected #{expected} assertions to be " +
      "fired during the test, not #{actual}"
  end

  # Specify that the assertion was expected to fail with the resulting message.
  def assert_assertion_triggered expected, klass = Minitest::Assertion
    e = assert_raises(klass) do
      yield
    end

    msg = e.message.sub(/(---Backtrace---).*/m, '\1')
    msg.gsub!(/\(oid=[-0-9]+\)/, '(oid=N)')
    msg.gsub!(/(\d\.\d{6})\d+/, '\1xxx') # normalize: ruby version, impl, platform

    assert_equal expected, msg
  end
end

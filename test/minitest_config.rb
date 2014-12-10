gem 'minitest'
require 'minitest/autorun'
require 'minitest/pretty_diff'
require 'minitest/focus'
require 'minitest/moar'
require 'minitest/bisect'

require 'minitest-bonus-assertions'

module Minitest::AssertionTester
  def setup
    super

    Minitest::Test.reset

    @tc = Minitest::Test.new 'fake tc'
    @zomg = "zomg ponies!"
    @assertion_count = 1
  end

  def teardown
    if @tc.assertions
      assert_equal @assertion_count, @tc.assertions,
        "expected #{@assertion_count} assertions to be fired during the test, not #{@tc.assertions}"
    end
    Object.send(:remove_const, :ATestCase) if defined? ATestCase
  end

  def util_assert_triggered expected, klass = Minitest::Assertion
    e = assert_raises(klass) do
      yield
    end

    msg = e.message.sub(/(---Backtrace---).*/m, '\1')
    msg.gsub!(/\(oid=[-0-9]+\)/, '(oid=N)')
    msg.gsub!(/(\d\.\d{6})\d+/, '\1xxx') # normalize: ruby version, impl, platform

    assert_equal expected, msg
  end

  Minitest::Test.send(:include, self)
end

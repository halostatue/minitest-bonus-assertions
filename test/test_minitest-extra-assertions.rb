require 'helper'

class TestMinitestExtraAssertions < Test::Unit::TestCase
  def setup
    super

    MiniTest::Unit::TestCase.reset

    @tc = MiniTest::Unit::TestCase.new 'fake tc'
    @zomg = "zomg ponies!"
    @assertion_count = 1
  end

  def teardown
    assert_equal(@assertion_count, @tc._assertions,
                 "expected #{@assertion_count} assertions to be fired during the test, not #{@tc._assertions}") if @tc._assertions
    Object.send :remove_const, :ATestCase if defined? ATestCase
  end

  def util_assert_triggered expected, klass = MiniTest::Assertion
    e = assert_raises(klass) do
      yield
    end

    msg = e.message.sub(/(---Backtrace---).*/m, '\1')
    msg.gsub!(/\(oid=[-0-9]+\)/, '(oid=N)')

    assert_equal expected, msg
  end

  context ".assert_true" do
    should "return true for true" do
      @assertion_count = 1

      assert_equal true, @tc.assert_true(true), "returns true for true"
    end

    should "be triggered for false or nil" do
      @assertion_count = 2

      util_assert_triggered "<true> expected but was false." do
        @tc.assert_true false
      end
      util_assert_triggered "<true> expected but was nil." do
        @tc.assert_true nil
      end
    end

    should "be triggered for things that aren't true but evaluate to true" do
      @assertion_count = 1

      util_assert_triggered "<true> expected but was Object." do
        @tc.assert_true Object
      end
    end
  end

  context ".assert_false" do
    should "return true for false" do
      @assertion_count = 1

      assert_equal true, @tc.assert_false(false), "returns true for false"
    end

    should "be triggered for nil" do
      @assertion_count = 1

      util_assert_triggered "<false> expected but was nil." do
        @tc.assert_false nil
      end
    end

    should "be triggered for things that evalute to true" do
      @assertion_count = 1

      util_assert_triggered "<false> expected but was Object." do
        @tc.assert_false Object
      end
    end
  end

  context ".assert_between" do
    should "return true for basic integers" do
      @assertion_count = 1
      assert_equal true, @tc.assert_between(1,10,5), "returns true for 1 to 10 and 5"
    end

    should "return true for the range case" do
      @assertion_count = 1
      assert_equal true, @tc.assert_between((1..10), 5), "returns true for 1..10 with 5"
    end

    should "handle the case where the hi part is first" do
      @assertion_count = 1
      assert_equal true, @tc.assert_between(10, 1, 5), "returns true for 10 to 1, with 5"
    end

    should "return false for values outside the bounds" do
      @assertion_count = 1
      util_assert_triggered "Expected 100 to be between 10 and 1." do
        @tc.assert_between(1, 10, 100)
      end
    end

    should "raise error for incompatible values" do
      @assertion_count = 0
      assert_raises ArgumentError do
        @tc.assert_between(1, 10, Time.now)
      end
    end
  end

  # This is pull-requested for minitest proper, hopefully will be merged soon
  def test_assert_match_unusual_object
    @assertion_count = 2
    unusual_object = Object.new
    def unusual_object.=~(other) true end
    @tc.assert_match /pattern/, unusual_object
  end

end

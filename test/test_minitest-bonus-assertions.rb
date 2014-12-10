# coding: utf-8

require 'minitest_config'

describe Minitest::BonusAssertions do
  describe ".assert_true" do
    it "return true for true" do
      @assertion_count = 1

      assert_equal true, @tc.assert_true(true), "returns true for true"
    end

    it "be triggered for false or nil" do
      @assertion_count = 2

      util_assert_triggered "<true> expected but was false." do
        @tc.assert_true false
      end
      util_assert_triggered "<true> expected but was nil." do
        @tc.assert_true nil
      end
    end

    it "be triggered for things that aren't true but evaluate to true" do
      @assertion_count = 1

      util_assert_triggered "<true> expected but was Object." do
        @tc.assert_true Object
      end
    end
  end

  describe ".assert_false" do
    it "return true for false" do
      @assertion_count = 1

      assert_equal true, @tc.assert_false(false), "returns true for false"
    end

    it "be triggered for nil" do
      @assertion_count = 1

      util_assert_triggered "<false> expected but was nil." do
        @tc.assert_false nil
      end
    end

    it "be triggered for things that evalute to true" do
      @assertion_count = 1

      util_assert_triggered "<false> expected but was Object." do
        @tc.assert_false Object
      end
    end
  end

  describe ".assert_between" do
    it "return true for basic integers" do
      @assertion_count = 1
      assert_equal true, @tc.assert_between(1,10,5), "returns true for 1 to 10 and 5"
    end

    it "return true for the range case" do
      @assertion_count = 1
      assert_equal true, @tc.assert_between((1..10), 5), "returns true for 1..10 with 5"
    end

    it "handle the case where the hi part is first" do
      @assertion_count = 1
      assert_equal true, @tc.assert_between(10, 1, 5), "returns true for 10 to 1, with 5"
    end

    it "return false for values outside the bounds" do
      @assertion_count = 1
      util_assert_triggered "Expected 100 to be between 1 and 10." do
        @tc.assert_between(1, 10, 100)
      end
    end

    it "raise error for incompatible values" do
      @assertion_count = 0
      assert_raises ArgumentError do
        @tc.assert_between(1, 10, Time.now)
      end
    end
  end

  describe ".assert_has_keys" do
    it "return true if the keys are present" do
      @assertion_count = 1
      assert_equal true, @tc.assert_has_keys({ "a" => 1 }, "a"), %Q(returns true for key 'a' in {"a"=>1})
    end

    it "be triggered for a missing value" do
      @assertion_count = 2
      hash = { "a" => 1 }
      keys = %w(a b)
      util_assert_triggered %Q(Expected #{mu_pp(hash)} to include all keys #{mu_pp(keys)}.) do
        @tc.assert_has_keys(hash, keys)
      end
    end

    it "raise error for incompatible values" do
      @assertion_count = 0
      assert_raises NoMethodError do
        @tc.assert_has_keys([], "a")
      end
    end
  end

  describe ".assert_missing_keys" do
    it "return true if the keys are missing" do
      @assertion_count = 1
      assert_equal true, @tc.assert_missing_keys({ "a" => 1 }, "b"), "returns true for key 'b' missing from { 'a' => 1 }"
    end

    it "be triggered for a present value" do
      @assertion_count = 1
      hash = { "a" => 1 }
      keys = %w(a b)
      util_assert_triggered %Q(Expected #{mu_pp(hash)} not to include any of these keys #{mu_pp(keys)}.) do
        @tc.assert_missing_keys(hash, keys)
      end
    end

    it "raise error for incompatible values" do
      @assertion_count = 0
      assert_raises NoMethodError do
        @tc.assert_missing_keys([], "a")
      end
    end
  end

  describe ".assert_raises_with_message" do
    it "return the matched exception if the exception and message match" do
      @assertion_count = 2

      res = @tc.assert_raises_with_message(ArgumentError, "Don't have a cow, man!") do
        raise ArgumentError, "Don't have a cow, man!"
      end

      assert_kind_of ArgumentError, res
    end

    it "is triggered with a different exception" do
      @assertion_count = 1

      util_assert_triggered %Q(#{mu_pp([ArgumentError])} exception expected, not\nClass: <NoMethodError>\nMessage: <"NoMethodError">\n---Backtrace---) do
        @tc.assert_raises_with_message(ArgumentError, "Don’t have a cow, man!") do
          raise NoMethodError
        end
      end
    end

    it "be triggered with a different message" do
      @assertion_count = 2
      util_assert_triggered %Q(ArgumentError exception expected with message "Don’t have a cow, man!".\nExpected: "Don’t have a cow, man!"\n  Actual: "Have a cow, man!") do
        @tc.assert_raises_with_message(ArgumentError, "Don’t have a cow, man!") do
          raise ArgumentError, "Have a cow, man!"
        end
      end
    end
  end
end

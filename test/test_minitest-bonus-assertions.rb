# coding: utf-8

require 'minitest_config'

describe Minitest::BonusAssertions do
  include Minitest::AssertionTests

  describe '.assert_true' do
    it 'returns true for true' do
      assert_expected_assertions do
        assert_equal true, tc.assert_true(true), 'returns true for true'
      end
    end

    it 'be triggered for false or nil' do
      assert_expected_assertions 2 do
        assert_assertion_triggered '<true> expected but was false.' do
          tc.assert_true false
        end

        assert_assertion_triggered '<true> expected but was nil.' do
          tc.assert_true nil
        end
      end
    end

    it %q(be triggered for things that aren't true but evaluate to true) do
      assert_expected_assertions do
        assert_assertion_triggered '<true> expected but was Object.' do
          tc.assert_true Object
        end
      end
    end
  end

  describe '.assert_false' do
    it 'returns true for false' do
      assert_expected_assertions do
        assert_equal true, tc.assert_false(false), 'returns true for false'
      end
    end

    it 'be triggered for nil' do
      assert_expected_assertions do
        assert_assertion_triggered '<false> expected but was nil.' do
          tc.assert_false nil
        end
      end
    end

    it 'be triggered for things that evalute to true' do
      assert_expected_assertions do
        assert_assertion_triggered '<false> expected but was Object.' do
          tc.assert_false Object
        end
      end
    end
  end

  describe '.assert_between' do
    it 'returns true for basic integers' do
      assert_expected_assertions do
        assert_equal true, tc.assert_between(1, 10, 5), 'returns true for 1 to 10 and 5'
      end
    end

    it 'returns true for the range case' do
      assert_expected_assertions do
        assert_equal true, tc.assert_between((1..10), 5), 'returns true for 1..10 with 5'
      end
    end

    it 'handle the case where the hi part is first' do
      assert_expected_assertions do
        assert_equal true, tc.assert_between(10, 1, 5), 'returns true for 10 to 1, with 5'
      end
    end

    it 'returns false for values outside the bounds' do
      assert_expected_assertions do
        assert_assertion_triggered 'Expected 100 to be between 1 and 10.' do
          tc.assert_between(1, 10, 100)
        end
      end
    end

    it 'returns false for values strictly on the bounds' do
      assert_expected_assertions do
        assert_assertion_triggered 'Expected 1 to be between 1 and 10.' do
          tc.assert_between(1, 10, 1)
        end
      end
    end

    it 'raise error for incompatible values' do
      assert_expected_assertions 0 do
        assert_raises ArgumentError do
          tc.assert_between(1, 10, Time.now)
        end
      end
    end

    it 'works correctly with the new expectation format' do
      assert_expected_assertions do
        assert_equal true, spec._(5).must_be_between(1, 10)
      end
    end
  end

  describe '.assert_has_keys' do
    it 'returns true if the keys are present' do
      assert_expected_assertions do
        assert_equal true, tc.assert_has_keys({ 'a' => 1 }, 'a'),
          %q(returns true for key 'a' in { 'a' => 1 })
      end
    end

    it 'be triggered for a missing value' do
      hash = { 'a' => 1 }
      keys = %w(a b)
      assert_expected_assertions 2 do
        assert_assertion_triggered %Q(Expected #{mu_pp(hash)} to include all keys #{mu_pp(keys)}.) do
          tc.assert_has_keys(hash, keys)
        end
      end
    end

    it 'raise error for incompatible values' do
      assert_expected_assertions 0 do
        assert_raises NoMethodError do
          tc.assert_has_keys([], 'a')
        end
      end
    end
  end

  describe '.assert_missing_keys' do
    it 'returns true if the keys are missing' do
      assert_expected_assertions do
        assert_equal true, tc.assert_missing_keys({ 'a' => 1 }, 'b'),
          %q(returns true for key 'b' missing from { 'a' => 1 })
      end
    end

    it 'be triggered for a present value' do
      hash = { 'a' => 1 }
      keys = %w(a b)
      assert_expected_assertions do
        assert_assertion_triggered %Q(Expected #{mu_pp(hash)} not to include any of these keys #{mu_pp(keys)}.) do
          tc.assert_missing_keys(hash, keys)
        end
      end
    end

    it 'raise error for incompatible values' do
      assert_expected_assertions 0 do
        assert_raises NoMethodError do
          tc.assert_missing_keys([], 'a')
        end
      end
    end
  end

  describe '.assert_raises_with_message' do
    it 'returns the matched exception if the exception and message match' do
      assert_expected_assertions 2 do
        res = tc.assert_raises_with_message(ArgumentError, %q(Don't have a cow, man!)) do
          raise ArgumentError, %q(Don't have a cow, man!)
        end

        assert_kind_of ArgumentError, res
      end
    end

    it 'is triggered with a different exception' do
      assert_expected_assertions do
        assert_assertion_triggered %Q(#{mu_pp([ArgumentError])} exception expected, not\nClass: <NoMethodError>\nMessage: <"NoMethodError">\n---Backtrace---) do
          tc.assert_raises_with_message(ArgumentError, 'Don’t have a cow, man!') do
            raise NoMethodError
          end
        end
      end
    end

    it 'be triggered with a different message' do
      assert_expected_assertions 2 do
        assert_assertion_triggered %Q(ArgumentError exception expected with message "Don’t have a cow, man!".\nExpected: "Don’t have a cow, man!"\n  Actual: "Have a cow, man!") do
          tc.assert_raises_with_message(ArgumentError, 'Don’t have a cow, man!') do
            raise ArgumentError, 'Have a cow, man!'
          end
        end
      end
    end
  end

  describe '.assert_set_equal' do
    it 'returns true if the sets are equal' do
      assert_expected_assertions do
        assert_equal true, tc.assert_set_equal(%w(a b c), %w(c b a)),
          %q(returns true for sets %w(a b c) and %w(c b a))
      end
    end

    it 'is triggered if they are not equal' do
      assert_expected_assertions do
        assert_assertion_triggered %Q(Expected [\n  \"c\",\n  \"b\"\n] to be set equivalent to [\n  \"a\",\n  \"b\",\n  \"c\"\n].\nExpected: #<Set: {\"a\", \"b\", \"c\"}>\n  Actual: #<Set: {\"c\", \"b\"}>) do
          tc.assert_set_equal %w(a b c), %w(c b)
        end
      end
    end
  end

  describe '.refute_set_equal' do
    it 'returns true if the sets are not equal' do
      assert_expected_assertions do
        assert_equal false, tc.refute_set_equal(%w(a b c), %w(c b)),
          %q(returns true for sets %w(a b c) and %w(c b))
      end
    end

    it 'is triggered if they are not equal' do
      assert_expected_assertions do
        assert_assertion_triggered %Q(Expected [\n  \"c\",\n  \"b\",\n  \"a\"\n] not to be set equivalent to [\n  \"a\",\n  \"b\",\n  \"c\"\n].\nExpected #<Set: {\"c\", \"b\", \"a\"}> to not be equal to #<Set: {\"a\", \"b\", \"c\"}>.) do
          tc.refute_set_equal %w(a b c), %w(c b a)
        end
      end
    end
  end

  describe '.assert_result_equal' do
    describe 'when expr is a string' do
      let(:expr) { 'expected' }

      describe 'when expr yields nil' do
        before do
          tc.define_singleton_method(:expected) { nil }
          spec.define_singleton_method(:expected) { nil }
        end

        it 'returns true if the actual is nil' do
          assert_expected_assertions do
            assert_equal true, tc.assert_result_equal('expected', nil),
              %q(returns true for expr-string result nil and nil)
          end
        end

        it 'returns true if the actual is nil' do
          assert_expected_assertions do
            assert_equal true, tc.assert_result_equal('expected', nil),
              %q(returns true for expr-string result nil and nil)
          end
        end

        it 'is triggered if the actual is not nil' do
          assert_expected_assertions do
            assert_assertion_triggered %Q(nil expected (expr \"expected\") but was 3.\nExpected 3 to be nil.) do
              assert_equal true, tc.assert_result_equal('expected', 3),
                %q(returns true for expr-string result nil and nil)
            end
          end
        end
      end

      describe 'when expr yields a non-nil value' do
        before do
          tc.define_singleton_method(:expected) { 3 }
        end

        it 'returns true if the actual is equal' do
          assert_expected_assertions do
            assert_equal true, tc.assert_result_equal('expected', 3),
              %q(returns true for expr-string result 3 and 3)
          end
        end

        it 'is triggered if the actual is nil' do
          assert_expected_assertions do
            assert_assertion_triggered %Q(3 expected (expr \"expected\") but was nil.\nExpected: 3\n  Actual: nil) do
              assert_equal true, tc.assert_result_equal('expected', nil),
                %q(returns true for expr-string result 3 and 3)
            end
          end
        end

        it 'is triggered if the actual is not equal' do
          assert_expected_assertions do
            assert_assertion_triggered %Q(3 expected (expr \"expected\") but was 5.\nExpected: 3\n  Actual: 5) do
              assert_equal true, tc.assert_result_equal('expected', 5),
                %q(returns true for expr-string result 3 and 3)
            end
          end
        end
      end
    end

    describe 'when expr is a proc' do
      let(:expr) { -> { expected } }

      describe 'when expr yields nil' do
        before do
          tc.define_singleton_method(:expected) { nil }
        end

        it 'returns true if the actual is nil' do
          assert_expected_assertions do
            assert_equal true, tc.assert_result_equal('expected', nil),
              %q(returns true for expr-proc result nil and nil)
          end
        end

        it 'is triggered if the actual is not nil' do
          assert_expected_assertions do
            assert_assertion_triggered %Q(nil expected (expr \"expected\") but was 3.\nExpected 3 to be nil.) do
              assert_equal true, tc.assert_result_equal('expected', 3),
                %q(returns true for expr-proc result nil and nil)
            end
          end
        end
      end

      describe 'when expr yields a non-nil value' do
        before do
          tc.define_singleton_method(:expected) { 3 }
        end

        it 'returns true if the actual is equal' do
          assert_expected_assertions do
            assert_equal true, tc.assert_result_equal('expected', 3),
              %q(returns true for expr-proc result 3 and 3)
          end
        end

        it 'is triggered if the actual is nil' do
          assert_expected_assertions do
            assert_assertion_triggered %Q(3 expected (expr \"expected\") but was nil.\nExpected: 3\n  Actual: nil) do
              assert_equal true, tc.assert_result_equal('expected', nil),
                %q(returns true for expr-proc result 3 and 3)
            end
          end
        end

        it 'is triggered if the actual is not equal' do
          assert_expected_assertions do
            assert_assertion_triggered %Q(3 expected (expr \"expected\") but was 5.\nExpected: 3\n  Actual: 5) do
              assert_equal true, tc.assert_result_equal('expected', 5),
                %q(returns true for expr-proc result 3 and 3)
            end
          end
        end
      end
    end
  end
end

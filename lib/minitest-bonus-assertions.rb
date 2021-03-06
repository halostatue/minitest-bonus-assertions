module Minitest
  module BonusAssertions # :nodoc:
    VERSION = '3.0' # :nodoc:
  end

  module Assertions
    ##
    # Fails unless +obj+ is literally +false+.

    def assert_false obj, msg = nil
      msg = message(msg) { "<false> expected but was #{mu_pp(obj)}" }
      assert obj == false, msg
    end

    ##
    # Fails unless +obj+ is literally +true+.

    def assert_true obj, msg = nil
      msg = message(msg) { "<true> expected but was #{mu_pp(obj)}" }
      assert obj == true, msg
    end

    ##
    # Fails unless +exp+ is between +lo+ and +hi+, or is in +range+. This test
    # is exclusive of the boundaries. That is:
    #
    #   assert_between 1, 10, 1
    #
    # will return false, but:
    #
    #   assert_between 0.99, 10.1, 1
    #
    # will return true.
    #
    # :call-seq:
    #    assert_between lo, hi, exp, msg = nil
    #    assert_between range, exp, msg = nil

    def assert_between(*args)
      lo, hi, exp, msg = if args.first.kind_of?(Range)
                           [args.first.begin, args.first.end, args[1], args[2]]
                         else
                           args[0..3]
                         end
      lo, hi = hi, lo if lo > hi
      msg = message(msg) { "Expected #{mu_pp(exp)} to be between #{mu_pp(lo)} and #{mu_pp(hi)}" }
      assert (lo < exp && exp < hi), msg
    end

    ##
    # Fails unless +obj+ has all of the +keys+ listed.

    def assert_has_keys obj, keys, msg = nil
      keys = [ keys ] unless keys.kind_of?(Array)
      msg = message(msg) { "Expected #{mu_pp(obj)} to include all keys #{mu_pp(keys)}" }
      keys.all? { |key| assert obj.key?(key), msg }
    end
    alias_method :refute_missing_keys, :assert_has_keys

    ##
    # Fails if +obj+ has any of the keys listed.

    def assert_missing_keys obj, keys, msg = nil
      keys = [ keys ] unless keys.kind_of?(Array)
      msg = message(msg) {
        "Expected #{mu_pp(obj)} not to include any of these keys #{mu_pp(keys)}"
      }
      keys.none? { |key| refute obj.key?(key), msg }
    end
    alias_method :refute_has_keys, :assert_missing_keys

    ##
    # Fails unless the block raises +exp+ with the message +exp_msg+. Returns
    # the exception matched so you can check other attributes.

    def assert_raises_with_message exp, exp_msg, msg = nil
      msg = message(msg) { "#{mu_pp(exp)} exception expected with message #{mu_pp(exp_msg)}" }

      exception = assert_raises exp do
        yield
      end

      assert_equal exp_msg, exception.message, msg
      exception
    end

    ##
    # Fails unless the set from +actual+ matches the set from +exp+.

    def assert_set_equal expected, actual, msg = nil
      require 'set'
      msg = message(msg) {
        "Expected #{mu_pp(actual)} to be set equivalent to #{mu_pp(expected)}"
      }
      assert_equal Set.new(expected), Set.new(actual), msg
    end

    ##
    # Fails unless the set from +actual+ differs from the set from +exp+.

    def refute_set_equal expected, actual, msg = nil
      require 'set'
      msg = message(msg) {
        "Expected #{mu_pp(actual)} not to be set equivalent to #{mu_pp(expected)}"
      }
      refute_equal Set.new(expected), Set.new(actual), msg
    end

    ##
    # Fails unless +actual+ is the same value as the result of evaluating
    # +expr+ in the context of the test case through instance_eval (when +expr+
    # is a String) or instance_exec (when +expr+ is a callable).
    #
    # If +expr+ results in +nil+, this test delegates to #assert_nil, otherwise
    # it delegates to #assert_equal.
    #
    # This assertion exists because Minitest 6 is changing #assert_equal so
    # that it fails when comparing against +nil+.
    #
    #   assert_result_equal -> { model.department }, response[:department]
    #   assert_result_equal 'model.department', response[:department]
    def assert_result_equal expr, actual, msg = nil
      result = if expr.respond_to?(:call)
                 instance_exec(&expr)
               else
                 instance_eval(expr)
               end

      if result.nil?
        msg = message(msg) {
          "nil expected (expr #{mu_pp(expr)}) but was #{mu_pp(actual)}"
        }
        assert_nil actual, msg
      else
        msg = message(msg) {
          "#{mu_pp(result)} expected (expr #{mu_pp(expr)}) but was #{mu_pp(actual)}"
        }
        assert_equal result, actual, msg
      end
    end
  end

  module Expectations
    ##
    # See Minitest::Assertions#assert_false
    #
    #    false.must_be_false
    #
    # :method: must_be_false

    infect_an_assertion :assert_false, :must_be_false, :unary

    ##
    # See Minitest::Assertions#assert_true
    #
    #    true.must_be_true
    #
    # :method: must_be_true

    infect_an_assertion :assert_true, :must_be_true, :unary

    ##
    # See Minitest::Assertions#assert_between
    #
    #   2.must_be_between 1, 3
    #   2.must_be_between 1..3

    def must_be_between *args
      hi, lo, msg  = if args.first.kind_of?(Range)
                       [args.first.begin, args.first.end, args[1]]
                     else
                       args[0..2]
                     end
      ctx.assert_between lo, hi, target, msg
    end

    ##
    # See Minitest::Assertions#assert_has_keys
    #
    #    hash.must_have_keys %w(a b c)
    #
    # :method: must_have_keys

    infect_an_assertion :assert_has_keys, :must_have_keys, :unary

    ##
    # See Minitest::Assertions#assert_missing_keys
    #
    #    hash.must_not_have_keys %w(a b c)
    #
    # :method: must_not_have_keys

    infect_an_assertion :assert_missing_keys, :must_not_have_keys, :unary

    ##
    # See Minitest::Assertions#assert_raises_with_message
    #
    #    proc { ... }.must_raise_with_message exception, message
    #
    # :method: must_raise_with_message

    infect_an_assertion :assert_raises_with_message, :must_raise_with_message

    ##
    # See Minitest::Assertions#assert_set_equal
    #
    #    %w(a b c).must_equal_set %(c b a)
    #
    # :method: must_equal_set

    infect_an_assertion :assert_set_equal, :must_equal_set, :unary

    ##
    # See Minitest::Assertions#refute_set_equal
    #
    #    %w(a b c).must_equal_set %(c b a)
    #
    # :method: must_equal_set

    infect_an_assertion :refute_set_equal, :must_not_equal_set, :unary

    ##
    # See Minitest::Assertions#assert_result_equal
    #
    #   response[:department].must_equal_result 'model.department'
    #   response[:department].must_equal_result -> { model.department }

    infect_an_assertion :assert_result_equal, :must_equal_result, :unary
  end
end

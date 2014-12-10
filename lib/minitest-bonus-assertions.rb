module Minitest
  module BonusAssertions
    VERSION = '1.0'
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
    # Fails unless +exp+ is between +lo+ and +hi+, or is in +range+.
    #
    # :call-seq:
    #    assert_between lo, hi, exp, msg = nil
    #    assert_between range, exp, msg = nil

    def assert_between(*args)
      lo, hi, exp, msg = if args.first.is_a?(Range)
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
      keys = [ keys ] unless keys.is_a?(Array)
      msg = message(msg) { "Expected #{mu_pp(obj)} to include all keys #{mu_pp(keys)}" }
      keys.all? { |key| assert obj.key?(key), msg }
    end
    alias_method :refute_missing_keys, :assert_has_keys

    ##
    # Fails if +obj+ has any of the keys listed.
    def assert_missing_keys obj, keys, msg = nil
      keys = [ keys ] unless keys.is_a?(Array)
      msg = message(msg) { "Expected #{mu_pp(obj)} not to include any of these keys #{mu_pp(keys)}" }
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
      hi, lo, msg  = if args.first.is_a?(Range)
                       [args.first.begin, args.first.end, args[1]]
                     else
                       args[0..2]
                     end
      assert_between lo, hi, self
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
  end
end

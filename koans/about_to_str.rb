require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutToStr < Neo::Koan

  # Explanation of the difference between .to_s and .to_str
  #
  # * "to_s" is a built-in that always returns some kind of string
  #   representation of an object, even if it's not "useful",
  #   e.g. looks like #<Demo:0x007fc49b05a408>
  #
  # * "to_str" is a user-defined method employed to actually state
  #   that the object behaves like a string, and return a useful value.
  #
  # source: http://marcgg.com/blog/2017/01/23/ruby-to-s-to-str/

  class CanNotBeTreatedAsString
    def to_s
      "non-string-like"
    end
    # This would make the assert_raise() fail
    # as no exceptioni would be thrown
    #alias :to_str :to_s
  end

  def test_to_s_returns_a_string_representation
    not_like_a_string = CanNotBeTreatedAsString.new
    assert_equal "non-string-like", not_like_a_string.to_s
  end

  def test_normally_objects_cannot_be_used_where_strings_are_expected
    assert_raise(TypeError) do
      File.exist?(CanNotBeTreatedAsString.new)
    end
  end

  # ------------------------------------------------------------------

  class CanBeTreatedAsString
    def to_s
      "string-like"
    end

    def to_str
      to_s
    end
  end

  def test_to_str_also_returns_a_string_representation
    like_a_string = CanBeTreatedAsString.new
    assert_equal "string-like", like_a_string.to_str
  end

  def test_to_str_allows_objects_to_be_treated_as_strings
    assert_equal false, File.exist?(CanBeTreatedAsString.new)
  end

  # ------------------------------------------------------------------

  def acts_like_a_string?(string)
    string = string.to_str if string.respond_to?(:to_str)
    string.is_a?(String)
  end

  def test_user_defined_code_can_check_for_to_str
    assert_equal false, acts_like_a_string?(CanNotBeTreatedAsString.new)
    assert_equal true,  acts_like_a_string?(CanBeTreatedAsString.new)
  end
end

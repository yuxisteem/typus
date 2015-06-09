require "test_helper"

class HashTest < ActiveSupport::TestCase

  test "cleanup" do
    %w(controller action id _input _popup resource attribute).each do |w|
      expected = { w => w }
      assert_equal expected, expected.dup.cleanup
    end

    hash = {_nullify: 'dragonfly'}
    assert hash.cleanup.empty?
  end

end

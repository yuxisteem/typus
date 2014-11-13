require 'test_helper'

class Admin::Resources::DataTypes::StringHelperTest < ActiveSupport::TestCase

  include Admin::Resources::DisplayHelper
  include Admin::Resources::DataTypes::StringHelper

  test 'display_string' do
    entry = entries(:default)
    assert_equal 'Default Entry', display_string(entry, :title)

    ["", nil].each do |value|
      entry.title = value
      assert_equal '&mdash;', display_string(entry, :title)
    end
  end

end

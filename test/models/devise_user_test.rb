require 'test_helper'

=begin

  Here we test:

  - Typus::Orm::ActiveRecord::User::InstanceMethods

=end

class DeviseUserTest < ActiveSupport::TestCase

  test 'to_label' do
    user = devise_users(:default)
    assert_equal user.email, user.to_label
  end

  test 'can?' do
    user = devise_users(:default)
    assert user.can?('delete', TypusUser)
    assert_not user.cannot?('delete', TypusUser)
    assert user.can?('delete', 'TypusUser')
    assert_not user.cannot?('delete', 'TypusUser')
  end

  test 'is_root?' do
    user = devise_users(:default)
    assert user.is_root?
    assert_not user.is_not_root?
  end

  test 'role' do
    user = devise_users(:default)
    assert_equal 'admin', user.role
  end

  test 'locale' do
    user = devise_users(:default)
    assert_equal :en, user.locale
  end

end

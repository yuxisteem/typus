require "test_helper"

=begin

  Here we test:

  - Typus::Orm::ActiveRecord::User::InstanceMethods

=end

class UserTest < ActiveSupport::TestCase

  test 'to_label' do
    typus_user = typus_users(:admin)
    assert_equal typus_user.email, typus_user.to_label
  end

  test 'can?' do
    typus_user = typus_users(:admin)
    assert typus_user.can?('delete', TypusUser)
    assert_not typus_user.cannot?('delete', TypusUser)
    assert typus_user.can?('delete', 'TypusUser')
    assert_not typus_user.cannot?('delete', 'TypusUser')
  end

  test 'is_root?' do
    typus_user = typus_users(:admin)
    assert typus_user.is_root?
    assert_not typus_user.is_not_root?
  end

  test 'active?' do
    typus_user = typus_users(:admin)
    assert typus_user.active?

    typus_user.status = false
    assert_not typus_user.active?

    typus_user.role = 'unexisting'
    assert_not typus_user.active?

    typus_user.status = true
    assert_not typus_user.active?
  end

end

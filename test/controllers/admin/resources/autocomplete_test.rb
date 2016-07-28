require "test_helper"

=begin

  What's being tested here?

    - Admin::Autocomplete

=end

class Admin::EntriesControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
  end

  test 'autocomplete returns up to 20 items' do
    create_25_entries

    get :autocomplete, params: { search: 'Entry' }
    assert_response :success
    assert_equal 20, assigns(:items).size
  end

  test 'autocomplete with a search result' do
    create_25_entries

    entry = entries(:default)
    entry.update_columns(id: 10_000, title: 'fesplugas')

    get :autocomplete, params: { search: 'fesp' }
    assert_response :success

    assert assigns(:items).size.eql?(1)

    assert_match %Q["id":10000], response.body
    assert_match %Q["name":"fesplugas"], response.body
  end

  test 'autocomplete with only a search result' do
    create_25_entries

    get :autocomplete, params: { search: 'jmeiss' }
    assert_response :success
    assert assigns(:items).empty?
    assert_equal '[]', response.body
  end

  def create_25_entries
    25.times do  |i|
      Entry.create(
        title: "Entry #{i}",
        content: 'Default Content of the Default Entry'
      )
    end
  end

end

require "test_helper"

=begin

  What's being tested here?

    - CRUD

=end

class Admin::EntriesControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
  end

  test 'get index' do
    get :index
    assert_response :success
    assert_template 'index'
  end

  test 'get index with scope' do
    get :index, params: { scope: 'published' }
    assert_response :success
    assert_template 'index'

    %w(delete_all).each do |scope|
      get :index, params: { scope: scope }
      assert_response :unprocessable_entity
      assert_equal 'Not allowed! Requested scope not defined on your whitelist.', response.body
      assert_not Entry.count.eql?(0)
    end
  end

  test 'get new' do
    get :new
    assert_response :success
    assert_template 'new'
  end

  test 'get new ignores url params' do
    %w(chunky_bacon).each do |param|
      get :new, params: { param => param }
      assert_response :success
      assert_template 'new'
    end
  end

  test 'get new reads params[:resource]' do
    get :new, params: { resource: { title: 'Chunky Bacon' } }
    assert_response :success
    assert_template 'new'
    assert_equal 'Chunky Bacon', assigns(:item).title
  end

  test 'post create and redirect to index' do
    entry_data = entries(:default).attributes
    entry_data.delete('id')

    assert_difference('Entry.count') do
      post :create, params: { entry: entry_data, _save: true }
      assert_response :redirect
      assert_redirected_to '/admin/entries'
    end
  end

  test 'post create and redirect to add new' do
    entry_data = entries(:default).attributes
    entry_data.delete('id')

    assert_difference('Entry.count') do
      post :create, params: { entry: entry_data, _addanother: true }
      assert_response :redirect
      assert_redirected_to '/admin/entries/new'
    end
  end

  test 'post create and continue editing' do
    entry_data = entries(:default).attributes
    entry_data.delete('id')

    assert_difference('Entry.count') do
      post :create, params: { entry: entry_data, _continue: true }
      assert_response :redirect
      assert_redirected_to "/admin/entries/edit/#{Entry.last.id}"
    end
  end

  test 'get show' do
    get :show, params: { id: entries(:default) }
    assert_response :success
    assert_template 'show'
  end

  test 'get edit' do
    get :edit, params: { id: entries(:default) }
    assert_response :success
    assert_template 'edit'
  end

  test 'post update and redirect to index' do
    post :update, params: { id: entries(:default), entry: { title: 'Updated' }, _save: true }
    assert_response :redirect
    assert_redirected_to '/admin/entries'
  end

  test 'get toggle' do
    @request.env['HTTP_REFERER'] = '/admin/entries'
    entry = entries(:default)

    assert entry.published
    get :toggle, params: { id: entry, field: 'published' }

    assert_response :redirect
    assert_redirected_to @request.env['HTTP_REFERER']
    assert_not entry.reload.published
  end

  test 'get toggle redirects to edit when validation fails' do
    @request.env['HTTP_REFERER'] = '/admin/entries'
    entry = entries(:default)

    entry.update_column(:content, nil)
    get :toggle, params: { id: entry, field: 'published' }
    assert_response :success
    assert_template 'admin/resources/edit'
  end

end

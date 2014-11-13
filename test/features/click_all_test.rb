require 'feature_test_helper'

class ClickAllTest < Capybara::Rails::TestCase

  fixtures :typus_users

  before do
    Typus.stubs(:authentication).returns(:none) # auth is tested elsewhere
  end

  test 'all sections' do
    urls.each do |url|
      visit "/admin/#{url}"
    end
  end

  def urls
    %w(
      dashboard
      entries
      projects
      users
      assets
      cases
      comments
      pages
      posts
      article/entries
      entry_defaults
      categories
      entry_bulks
      entry_trashes
      typus_users
      devise_users
      birds
      dogs
      image_holders
      invoices
      orders
    )
  end

end

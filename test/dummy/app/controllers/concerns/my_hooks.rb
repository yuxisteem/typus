require 'active_support/concern'

module MyHooks

  extend ActiveSupport::Concern

  included do
    before_action :switch_label
  end

  def switch_label
  end

end

require 'active_support/concern'
require 'bcrypt'
require 'typus/orm/active_record/instance_methods'

module Typus
  module Orm
    module ActiveRecord
      module AdminUser

        extend ActiveSupport::Concern
        include Typus::Orm::ActiveRecord::InstanceMethods

        included do
          has_secure_password

          # attr_protected :role, :status

          validates :email, presence: true, uniqueness: true, format: { with: Typus::Regex::Email }
          validates :password, length: { minimum: 8 }, allow_nil: true
          validates :role, presence: true

          serialize :preferences

          before_save :set_token
        end

        module ClassMethods

          def authenticate(email, password)
            user = find_by_email_and_status(email, true)
            user && user.authenticate(password) ? user : nil
          end

          def generate(*args)
            options = args.extract_options!
            options[:password] ||= Typus.password
            options[:role] ||= Typus.master_role
            options[:status] = true
            user = new(options)
            user.save ? user : false
          end

          def roles
            Typus::Configuration.roles.keys.sort
          end

          def locales
            Typus.available_locales
          end

        end

        def locale
          (preferences && preferences[:locale]) ? preferences[:locale] : ::I18n.default_locale
        end

        def locale=(locale)
          self.preferences ||= {}
          self.preferences[:locale] = locale
        end

      end
    end
  end
end

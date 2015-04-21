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
          attr_reader   :password
          attr_accessor :password_confirmation
          attr_accessor :user_performing_update

          # attr_protected :role, :status

          validates :email, :presence => true, :uniqueness => true, :format => { :with => Typus::Regex::Email }
          validates :password, :confirmation => true
          validates :password_digest, :presence => true
          validate :password_must_be_strong
          validate :validate_role_and_status_changes, :if => :user_performing_update
          validates :role, :presence => true

          serialize :preferences

          before_save :set_token
        end

        module ClassMethods

          def authenticate(email, password)
            user = find_by_email_and_status(email, true)
            user && user.authenticated?(password) ? user : nil
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
            Typus::I18n.available_locales
          end

        end

        def locale
          (preferences && preferences[:locale]) ? preferences[:locale] : ::I18n.default_locale
        end

        def locale=(locale)
          self.preferences ||= {}
          self.preferences[:locale] = locale
        end

        def authenticated?(unencrypted_password)
          equal = BCrypt::Password.new(password_digest) == unencrypted_password
          equal ? self : false
        end

        def password=(unencrypted_password)
          @password = unencrypted_password
          self.password_digest = BCrypt::Password.create(unencrypted_password) unless unencrypted_password.blank?
        end

        def password_must_be_strong(count = 6)
          if password.present? && password.size < count
            errors.add(:password, :too_short, :count => count)
          end
        end

        def validate_role_and_status_changes
          updates_not_allowed = ((user_performing_update == self) || user_performing_update.cannot?('edit', self.class.name))
          errors.add(:status, 'cannot be changed') if status_changed? && updates_not_allowed
          errors.add(:role, 'cannot be changed') if role_changed? && updates_not_allowed
        end
      end
    end
  end
end

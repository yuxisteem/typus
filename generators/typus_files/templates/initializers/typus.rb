=begin

  # This is a list of the available configuration options for Typus 
  # and their defaults. Update them to fit your application needs.

  # Typus system wide options

  Typus::Configuration.options[:app_name] = '<%= application %>'
  Typus::Configuration.options[:config_folder] = 'config/typus'
  Typus::Configuration.options[:email] = 'admin@example.com'
  Typus::Configuration.options[:ignore_missing_translations] = true
  Typus::Configuration.options[:prefix] = 'admin'
  Typus::Configuration.options[:recover_password] = true
  Typus::Configuration.options[:root] = 'admin'
  Typus::Configuration.options[:ssl] = false
  Typus::Configuration.options[:templates_folder]
  Typus::Configuration.options[:user_class_name]
  Typus::Configuration.options[:user_fk]

  # Model options.

  Typus::Configuration.options[:edit_after_create] = true
  Typus::Configuration.options[:end_year] = Time.now.year + 1
  Typus::Configuration.options[:form_rows] = 10
  Typus::Configuration.options[:icon_on_boolean] = false
  Typus::Configuration.options[:minute_step] = 5
  Typus::Configuration.options[:nil] = 'nil'
  Typus::Configuration.options[:per_page] = 15
  Typus::Configuration.options[:sidebar_selector] = 10
  Typus::Configuration.options[:start_year] = Time.now.year - 10
  Typus::Configuration.options[:toggle] = true

=end

Typus::Configuration.options[:app_name] = '<%= application %>'

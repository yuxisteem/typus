require "generators/typus/controller_generator"

module Typus
  module Generators
    class ModelGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      namespace "typus:model"

      desc <<-DESC
Description:
  This generator creates controller and configuration files.

Examples:
  `rails generate typus:model user`
  This command creates 2 files like below.

* config/typus/user.yml
* app/controllers/admin/users_controller.rb

      DESC

      def generate_models
        Typus.reload!

        models = parse_model_args
        models.each do |model|
          generate_yaml(model)
          generate_controller(model)
        end
      end

      protected
      def configuration
        @configuration
      end

      def parse_args
        ARGV.map { |table| table.singularize.camelize.constantize }
      end

      def typus_models
        Typus.application_models.reject { |m| Typus.models.include?(m) }.map(&:constantize)
      end

      def parse_model_args
        ARGV.present? ? parse_args : typus_models
      end

      def create_yaml_data(model)
        option = {}

        relationships = [ :has_many, :has_one ].map do |relationship|
                          model.reflect_on_all_associations(relationship).map { |i| i.name.to_s }
                        end.flatten.join(", ")
        option[:base] = <<-RAW
#{model}:
  fields:
    default: #{fields_for(model, 'to_label')}
    form: #{fields_for(model)}
  relationships: #{relationships}
  application: Application
        RAW
        option[:roles] = "#{model}: create, read, update, delete"
        option
      end

      def generate_yaml(model)
        key = model.name.underscore

        @configuration = create_yaml_data(model)

        template(
          "config/typus/application.yml",
          "config/typus/#{key}.yml")
        template(
          "config/typus/application_roles.yml",
          "config/typus/#{key}_roles.yml")
      end

      def fields_for(model, *defaults)
        rejections = %w( ^id$ _type$ type created_at created_on updated_at updated_on deleted_at ).join("|")
        fields = model.table_exists? ? model.columns.map(&:name) : defaults
        fields.reject { |f| f.match(rejections) }.join(", ")
      end

      def generate_controller(model)
        Typus::Generators::ControllerGenerator.new([model.name.pluralize.camelize]).invoke_all
      end
    end

  end
end

module Admin::Resources::DataTypes::BooleanHelper

  def display_boolean(item, attribute)
    if (status = item.send(attribute).to_s).present?
      item.class.typus_boolean(attribute).rassoc(status).first
    else
      mdash
    end
  end

  def table_boolean_field(attribute, item)
    human_boolean = display_boolean(item, attribute)

    if admin_user.can?('edit', item.class)
      options = {
        controller: "/admin/#{item.class.to_resource}",
        action: 'toggle',
        id: item.id,
        field: attribute.gsub(/\?$/, '')
      }
      link_to human_boolean, options
    else
      human_boolean
    end
  end

  def boolean_filter(filter)
    values  = @resource.typus_boolean(filter)
    attribute = @resource.human_attribute_name(filter)

    items = [[attribute.titleize, '']]
    array = values.map { |k, v| ["#{attribute}:#{k.humanize}", v] }

    items + array
  end

end

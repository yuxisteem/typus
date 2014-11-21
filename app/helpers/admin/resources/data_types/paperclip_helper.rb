module Admin::Resources::DataTypes::PaperclipHelper

  def display_paperclip(item, attribute)
    typus_paperclip_preview(item, attribute, 'paperclip_form_preview')
  end

  def table_paperclip_field(attribute, item)
    typus_paperclip_preview(item, attribute)
  end

  def link_to_detach_attribute_for_paperclip(attribute)
    validators = @item.class.validators.delete_if { |i| i.class != Paperclip::Validators::AttachmentPresenceValidator }.map(&:attributes).flatten.map(&:to_s)
    attachment = @item.send(attribute)

    if attachment.present? && !validators.include?(attribute) && attachment
      attribute_i18n = @item.class.human_attribute_name(attribute)
      link = link_to(
        t('typus.buttons.remove'),
        { action: 'update', id: @item.id, _nullify: attribute, _continue: true },
        { data: { confirm: t('typus.shared.confirm_question') } }
      )

      label_text = <<-HTML
#{attribute_i18n}
<small>#{link}</small>
      HTML
      label_text.html_safe
    end
  end

  def typus_paperclip_preview(item, attribute, partial = 'paperclip_preview')
    data = item.send(attribute)
    return unless data.exists?

    styles = data.styles.keys
    if data.content_type =~ /^image\/.+/ && styles.include?(Typus.file_preview) && styles.include?(Typus.file_thumbnail)
      render "admin/templates/#{partial}",
             attachment: data,
             preview: data.url(Typus.file_preview),
             table_thumb: data.url(Typus.file_thumbnail),
             thumb: data.url(Typus.file_thumbnail),
             item: item,
             attribute: attribute
    else
      link_to data.original_filename, data.url(:original, false)
    end
  end

end

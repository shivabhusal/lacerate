# Author Shiva Bhusal
# Aug 2016
# in config/initializers/modify_rails_form_builder.rb
# This will add a new method in the `f` object available in Rails forms
class ActionView::Helpers::FormBuilder
  def error_message_for(field_name, prefix: nil, wrapper_tag: 'div', wrapper_class: '', icon_class: nil)
    if self.object.errors[field_name].present?
      model_name = self.object.class.base_class.name.downcase
      id_of_element = "#{model_name}_#{field_name}-error"
      target_elem_id = "#{model_name}_#{field_name}"
      class_name = 'validation-error'
      error_declaration_class = 'has-validation-error'

      prefix_content = prefix
      prefix_content = "#{field_name.to_s.capitalize} "   if prefix && prefix == true
      icon_content   = "<i class=\"#{icon_class}\"></i> " if icon_class.present?

      "<#{wrapper_tag} id=\"#{id_of_element}\" for=\"#{target_elem_id}\" class=\"#{class_name} #{wrapper_class}\">"\
      "#{icon_content}"\
      "#{prefix_content}"\
      "#{self.object.errors[field_name].join(', ')}"\
      "</#{wrapper_tag}>"\
      "<!-- Later JavaScript to add class to the parent element -->"\
      "<script>"\
          "document.onreadystatechange = function(){"\
            "$('##{id_of_element}').parent()"\
            ".addClass('#{error_declaration_class}');"\
          "}"\
      "</script>".html_safe
    end
  rescue
    nil
  end
end


# Prevent Rails to wrap errorous field with div.field_with_error
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

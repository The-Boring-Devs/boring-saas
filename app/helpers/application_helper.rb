module ApplicationHelper
  def input_field_classes(form = nil, field = nil)
    FormFieldClassBuilder.build(form, field, :input)
  end

  def label_field_classes(form = nil, field = nil)
    FormFieldClassBuilder.build(form, field, :label)
  end

  def check_box_classes
    "w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800"
  end

  def error_hint(form, field)
    if form.object.errors.where(field).count.positive?
      content_tag(:p, form.object.errors.where(field).first.full_message, class: "mt-2 text-sm text-red-600 dark:text-red-500")
    end
  end
end

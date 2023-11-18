class FormFieldClassBuilder
  BASE_CLASSES = {
    input: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500",
    label: "block mb-2 text-sm font-medium text-gray-900 dark:text-white"
  }.freeze

  ERROR_CLASSES = {
    input: "bg-red-50 border border-red-500 text-red-900 placeholder-red-700 text-sm rounded-lg focus:ring-red-500 dark:bg-gray-700 focus:border-red-500 block w-full p-2.5 dark:text-red-500 dark:placeholder-red-500 dark:border-red-500",
    label: "block mb-2 text-sm font-medium text-red-700 dark:text-red-500"
  }.freeze

  def self.build(form, field, type)
    if error_present?(form, field)
      ERROR_CLASSES[type]
    else
      BASE_CLASSES[type]
    end
  end

  def self.error_present?(form, field)
    form&.object&.errors&.where(field)&.present?
  end
end

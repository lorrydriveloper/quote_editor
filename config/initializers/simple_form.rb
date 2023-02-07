# frozen_string_literal: true

#
# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components to know
# more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }
#
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers(:default, class: 'form__group') do |b|
    b.use(:html5)
    b.use(:placeholder)
    b.use(:label, class: 'visually-hidden')
    b.use(:input, class: 'form__input', error_class: 'form__input--invalid')
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = 'btn'

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'error_notification'

  config.label_text = -> (label, required, _explicit_label) { "#{required} #{label}" }

  config.browser_validations = false

  config.boolean_label_class = 'form__checkbox-label'
end

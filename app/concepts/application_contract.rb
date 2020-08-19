# frozen_string_literal: true
class ApplicationContract < Reform::Form
  feature Reform::Form::Dry
  feature Reform::Form::Coercion
end

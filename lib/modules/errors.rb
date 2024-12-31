# frozen_string_literal: true

# default pre-defined validation rules from a box
module Errors
  def error_no_template(template)
    "template \"#{template}\" with rules does not exist"
  end

  def error_no_key(key, template)
    "\"#{key}\" key doesn't exist in the \"#{template}\" template"
  end

  def error_not_valid(key, rule)
    "#{key} is not valid, should be #{rule}"
  end

  def error_no_rule(rule)
    "validation rule \"#{rule}\" doesn't exist"
  end
end

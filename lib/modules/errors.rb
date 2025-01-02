# frozen_string_literal: true

# default pre-defined validation rules from a box
module Errors
  def error_no_template(template)
    "template \"#{template}\" with rules does not exist"
  end

  def error_required_key(key)
    "\"#{key}\" key is required in a hash"
  end

  def error_no_key(key, template)
    "\"#{key}\" key doesn't exist in the \"#{template}\" template"
  end

  def error_not_valid(key, rule, error_texts)
    return password_error(key) if rule == 'password' && error_texts[key.to_sym].nil?

    error_texts[key.to_sym].nil? ? "#{key} is not valid, should be #{rule}" : error_texts[key.to_sym]
  end

  def password_error(key)
    "#{key} should be a difficult password"
  end

  def error_no_rule(rule)
    "validation rule \"#{rule}\" doesn't exist"
  end
end

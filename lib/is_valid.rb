# frozen_string_literal: true

require_relative 'modules/validators'
require_relative 'modules/errors'

# Ruby Gem to make a validation of a variable or a hash, based on regular expressions
# or own pre-defined validation templates in an easy way. See full documentation on GitHub.
class IsValid
  include Validators
  include Errors

  @rules = {}
  @templates = {}
  @errors = {}
  @all_keys = false

  def initialize(settings = {})
    @templates = settings[:templates] || {}
    @errors = settings[:errors] || {}
    @all_keys = settings[:all_keys] || false
    rules = settings[:rules] || {}
    validators = init_rules
    @rules = validators.merge(rules)
  end

  def check(val, rules)
    validated = rules.is_a?(String) ? check_or_nil(val, @rules[rules.to_sym]) : check_one_of_rules(val, rules)
    validated.is_a?(Array) ? false : validated
  end

  def check_or_nil(val, rule)
    rule == 'nil' ? val.nil? : val.to_s.match?(rule)
  end

  def rule_exists(rule)
    !rule.nil? && @rules[rule.to_sym].nil?
  end

  def check_one_of_rules(val, rules, key = 'variable')
    errors = []
    rules.each do |rule|
      if rule_exists(rule)
        errors << error_no_rule(rule)
      elsif !check(val, rule)
        errors << error_not_valid(key, rule, @errors)
      end
    end
    !errors.empty? && errors.length == rules.length ? errors : true
  end

  def check_hash(hash_var, template)
    template_rules = @templates[template.to_sym]
    return [error_no_template(template)] if template_rules.nil?

    errors = []
    hash_var.each do |key, val|
      rules = template_rules[key.to_sym]
      if @all_keys && rules.nil?
        errors << error_no_key(key, template)
      elsif !rules.nil?
        rules = [rules] if rules.is_a?(String)
        validated = check_one_of_rules(val, rules, key)
        errors += validated if validated != true
      end
    end
    errors.empty? ? true : errors
  end
end

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

  def initialize(templates = {}, rules = {})
    validators = init_rules
    @rules = validators.merge(rules)
    @templates = templates
  end

  def check(var, rule_name)
    if rule_name[-1] == '*'
      rule_name = rule_name[0..-2]
      res = var.nil?
    end
    res ||= @rules[rule_name.to_sym].nil? ? var.nil? : var.to_s.match?(@rules[rule_name.to_sym])
    res
  end

  def check_hash(hash_var, template)
    rules = @templates[template.to_sym]
    return [error_no_template(template)] if rules.nil?

    errors = []
    hash_var.each do |key, val|
      rule = rules[key.to_sym]
      next if !rule.nil? && check(val, rule)

      error = rule.nil? ? error_no_key(key, template) : error_not_valid(key, rule)
      errors << error
      errors << error_no_rule(rule) if !rule.nil? && !@rules&.keys&.include?(rule.to_sym)
    end
    errors.empty? ? true : errors
  end
end

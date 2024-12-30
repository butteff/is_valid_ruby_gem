# frozen_string_literal: true

require_relative 'modules/validators'

# Ruby Gem to make a validation of a variable or a hash, based on regular expressions
# or own pre-defined validation templates in an easy way. See full documentation on GitHub.
class IsValid
  include Validators

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
    errors = []
    rules = @templates[template.to_sym]
    if rules.nil?
      p 'template with rules does not exist'
    else
      hash_var.each do |key, val|
        unless !rules[key.to_sym].nil? && check(val, rules[key.to_sym])
          errors << "#{key} is not valid, should be #{rules[key.to_sym]}"
        end
      end
    end
    errors.empty? ? true : errors
  end
end

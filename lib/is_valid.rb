# frozen_string_literal: true

class IsValid
  def initialize(templates = {}, rules = {})
    @rules = {
      integer: '^(\d)+$',
      float: '^(\d)+.(\d)+$',
      float_with_comma: '^(\d)+,(\d)+$',
      word: '^(\w)+$',
      words: '^(\w| )+$',
      sentence: '^(\w| |,)+(\.|!|\?)$',
      boolean: '^(1|0|true|false)$',
      url: '^(http://|https://)(.)+\.(.)+$',
      email: '^([a-z,A-Z,\-,\_,\.]*)@(.*)+\.(.*)$',
      any: '(.*)+',
      string: '(.*)+',
      nil: nil
    }
    @rules = @rules.merge(rules)
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
    if !rules.nil?
      hash_var.each do |key, val|
        errors << "#{key} is not valid, should be #{rules[key.to_sym]}" unless !rules[key.to_sym].nil? && check(val, rules[key.to_sym])
      end
    else
      p 'template with rules does not exist'
    end
    errors.empty? ? true : errors
  end
end

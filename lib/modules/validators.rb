# frozen_string_literal: true

# default pre-defined validation rules from a box
module Validators
  def init_rules
    {
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
  end
end

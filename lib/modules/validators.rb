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
      url: 'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      url_no_http: '^[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
      email: '^([a-z,A-Z,\-,\_,\.]*)@(.*)+\.(.*)$',
      any: '(.*)+',
      string: '^(.*)+$',
      uuid: '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      date_time: '^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$',
      date_ymd: '^(\d{4})-(\d{2})-(\d{2})$',
      date_dmy: '^(\d{2})\.(\d{2})\.(\d{4})$',
      time_hms: '^(\d{2}):(\d{2}):(\d{2})$',
      time_hm: '^(\d{2}):(\d{2})$',
      timestamp: '^(\d{10,})$'
    }
  end
end

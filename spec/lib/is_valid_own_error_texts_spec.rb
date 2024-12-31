# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe 'check own error texts' do
    it 'this hash is not valid and full of errors with own texts' do
      templates = {
        settings: {
          url: 'url',
          is_confirmed: 'boolean',
          interval: 'integer'
        }
      }

      hash_to_check = {
        url: 'it is not an url',
        is_confirmed: 'it is not about a boolean',
        interval: 'not an integer'
      }

      errors = {
        url: 'error text 1',
        is_confirmed: 'error text 2',
        interval: 'error text 3'
      }
      is_valid = IsValid.new({ templates: templates, errors: errors })
      expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(['error text 1', 'error text 2', 'error text 3'])
    end
  end
end

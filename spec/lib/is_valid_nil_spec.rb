# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check with nil' do
    context 'variables and hashes tests' do
      # sentence test
      it 'hash with a nil rule test' do
        templates = {
          settings: {
            name: 'string',
            girlfriend_name: %w[string nil] # string or nil rule
          }
        }

        # instance creation:
        is_valid = IsValid.new({ templates: templates })

        hash_data = {
          name: 'John',
          girlfriend_name: 'Anna'
        }

        validation = is_valid.check_hash(hash_data, 'settings') # valid

        expect(validation).to eq(true)
      end

      it 'another hash with a nil rule test' do
        templates = {
          settings: {
            name: 'string',
            girlfriend_name: %w[string nil] # string or nil rule
          }
        }

        # instance creation:
        is_valid = IsValid.new({ templates: templates })

        # hash to check:
        hash_data_nil = {
          name: 'John',
          girlfriend_name: nil
        }

        validation2 = is_valid.check_hash(hash_data_nil, 'settings') # valid too

        expect(validation2).to eq(true)
      end

      it 'nil variable test' do
        is_valid = IsValid.new
        name_var = nil
        validation3 = is_valid.check(name_var, 'nil') # true
        expect(validation3).to eq(true)
      end
    end
  end
end

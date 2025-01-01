# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'variables tests' do
      # sentence test
      it 'uuid regexp test' do
        is_valid = IsValid.new
        expect(is_valid.check('54b8cff3-1e66-4c7a-8bb0-21d522c561d8', 'uuid')).to eq(true)
      end

      it 'not uuid regexp test' do
        is_valid = IsValid.new
        expect(is_valid.check('54b8cff3-1e66-4c7a-8bb0-test', 'uuid')).to eq(false)
      end

      it 'hash with uuid test' do
        templates = {
          settings: {
            test_in_hash_value: 'uuid'
          }
        }

        hash_to_check = {
          test_in_hash_value: '54b8cff3-1e66-4c7a-8bb0-21d522c561d8'
        }

        is_valid = IsValid.new({ templates: templates })
        expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(true)
      end

      it 'uuid exception in hash' do
        templates = {
          uuid_hash: {
            url: 'url',
            test_in_hash_value: 'uuid'
          }
        }

        hash_to_check = {
          url: 'https://butteff.ru',
          test_in_hash_value: 'wrong value'
        }

        is_valid = IsValid.new({ templates: templates })
        expect(is_valid.check_hash(hash_to_check,
                                   'uuid_hash')).to eq(['test_in_hash_value is not valid, should be uuid'])
      end
    end
  end
end

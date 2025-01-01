# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'variables tests' do
      # sentence test
      it 'date_time regexp test' do
        is_valid = IsValid.new
        expect(is_valid.check('2025-01-01 16:25:12', 'date_time')).to eq(true)
      end

      it 'not date_time regexp test' do
        is_valid = IsValid.new
        expect(is_valid.check('no date', 'date_time')).to eq(false)
      end

      it 'date_time exception in hash' do
        templates = {
          date_time_hash: {
            url: 'url',
            test_in_hash_value: 'date_time'
          }
        }

        hash_to_check = {
          url: 'https://butteff.ru',
          test_in_hash_value: 'wrong value'
        }

        is_valid = IsValid.new({ templates: templates })
        expect(is_valid.check_hash(hash_to_check,
                                   'date_time_hash')).to eq(['test_in_hash_value is not valid, should be date_time'])
      end

      it 'hash with any dates and times test' do
        templates = {
          settings: {
            test_in_hash_value_date_ymd: 'date_ymd',
            test_in_hash_value_date_dmy: 'date_dmy',
            test_in_hash_value_time_hms: 'time_hms',
            test_in_hash_value_time_hm: 'time_hm',
            test_in_hash_value_date_time: 'date_time',
            test_in_hash_value_timestamp: 'timestamp'
          }
        }

        hash_to_check = {
          test_in_hash_value_date_ymd: '2025-01-31',
          test_in_hash_value_date_dmy: '31.12.2024',
          test_in_hash_value_time_hms: '17:00:55',
          test_in_hash_value_time_hm: '17:00',
          test_in_hash_value_date_time: '2025-01-01 16:25:12',
          test_in_hash_value_timestamp: '1735746224'
        }

        is_valid = IsValid.new({ templates: templates })
        expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(true)
      end
    end
  end
end

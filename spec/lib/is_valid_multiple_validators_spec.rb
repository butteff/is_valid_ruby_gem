# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe 'check hashes with multiple rules' do
    it 'checks a variable based on multiple validators' do
      is_valid = IsValid.new
      expect(is_valid.check_one_of_rules('http://butteff.ru', %w[email url])).to eq(true)
    end

    it 'checks a variable based on multiple validators' do
      is_valid = IsValid.new
      expect(is_valid.check_one_of_rules('butteff.ru@gmail.com', %w[email url])).to eq(true)
    end

    it 'checks a variable based on multiple validators' do
      is_valid = IsValid.new
      expect(is_valid.check_one_of_rules('wrong value',
                                         %w[email
                                            url])).to eq(['variable is not valid, should be email',
                                                          'variable is not valid, should be url'])
    end

    it 'checks a variable based on multiple validators' do
      is_valid = IsValid.new
      expect(is_valid.check('http://butteff.ru', %w[email url])).to eq(true)
    end

    it 'checks a variable based on multiple validators' do
      is_valid = IsValid.new
      expect(is_valid.check('butteff.ru@gmail.com', %w[email url])).to eq(true)
    end

    it 'checks a variable based on multiple validators' do
      is_valid = IsValid.new
      expect(is_valid.check('wrong value', %w[email url])).to eq(false)
    end

    it 'this hash is valid' do
      templates = {
        settings: {
          test_data: %w[url email],
          is_confirmed: %w[boolean integer],
          interval: %w[integer float]
        }
      }

      hash_to_check = {
        test_data: 'https://www.butteff.ru',
        is_confirmed: 'true',
        interval: '10'
      }

      is_valid = IsValid.new({ templates: templates })
      expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(true)
    end

    it 'this hash is valid too' do
      templates = {
        settings: {
          test_data: %w[url email],
          is_confirmed: %w[boolean integer],
          interval: %w[integer float]
        }
      }

      hash_to_check = {
        test_data: 'butteff.ru@yandex.ru',
        is_confirmed: '5',
        interval: '10.5'
      }

      is_valid = IsValid.new({ templates: templates })
      expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(true)
    end

    it 'this hash with multiple validators has an exception' do
      templates = {
        settings: {
          test_data: %w[url email],
          is_confirmed: %w[boolean integer],
          interval: %w[integer float]
        }
      }

      hash_to_check = {
        test_data: 'butteff.ru@yandex.ru',
        is_confirmed: '5',
        interval: 'string value'
      }

      is_valid = IsValid.new({ templates: templates })
      expect(is_valid.check_hash(hash_to_check,
                                 'settings')).to eq(['interval is not valid, should be integer',
                                                     'interval is not valid, should be float'])
    end
  end
end

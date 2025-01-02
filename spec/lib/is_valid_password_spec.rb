# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'password variables tests' do
      # boolean test
      it 'this password is ok' do
        is_valid = IsValid.new
        expect(is_valid.check('HeyP4ssw0rd++', 'password')).to eq(true)
      end

      it 'this password is ok too' do
        is_valid = IsValid.new
        expect(is_valid.check('HeS0m3P@ssW', 'password')).to eq(true)
      end

      it 'Short password' do
        is_valid = IsValid.new
        expect(is_valid.check('HeS0m3', 'password')).to eq(false)
      end

      it 'bad password' do
        is_valid = IsValid.new
        expect(is_valid.check('qwerty12345', 'password')).to eq(false)
      end

      it 'password error text' do
        template = {
          password_check: {
            pass: 'password'
          }
        }

        hash_to_check = {
          pass: 'badpasww'
        }
        is_valid = IsValid.new({ templates: template })
        expect(is_valid.check_hash(hash_to_check, 'password_check')).to eq(['pass should be a difficult password'])
      end
    end
  end
end

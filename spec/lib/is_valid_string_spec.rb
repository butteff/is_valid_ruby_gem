# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'string variables tests' do
      # boolean test
      it 'this variable is a string' do
        is_valid = IsValid.new
        expect(is_valid.check('butteff.ru@gmail.com', 'string')).to eq(true)
      end

      it 'this variable is a string too' do
        is_valid = IsValid.new
        expect(is_valid.check('any text here', 'string')).to eq(true)
      end

      it 'this variable is a string as well' do
        is_valid = IsValid.new
        expect(is_valid.check('just a few lines for a test:
          and it works!', 'string')).to eq(true)
      end

      it 'this variable is a string anyway' do
        is_valid = IsValid.new
        expect(is_valid.check('this is a string with numbers 123456 78910', 'string')).to eq(true)
      end

      it 'this variable is not a string' do
        is_valid = IsValid.new
        expect(is_valid.check(12_345, 'string')).to eq(false)
      end
    end
  end
end

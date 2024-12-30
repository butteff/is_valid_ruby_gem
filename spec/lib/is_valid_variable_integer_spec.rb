# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'variables tests' do
      # integer test
      it 'this variable is an integer' do
        is_valid = IsValid.new
        expect(is_valid.check('55', 'integer')).to eq(true)
      end

      it 'this variable is an integer with integer type' do
        is_valid = IsValid.new
        expect(is_valid.check(33, 'integer')).to eq(true)
      end

      it 'this variable is not an integer' do
        is_valid = IsValid.new
        expect(is_valid.check('22.3', 'integer')).to eq(false)
      end

      it 'this variable is not an integer with integer data type' do
        is_valid = IsValid.new
        expect(is_valid.check(22.3, 'integer')).to eq(false)
      end

      it 'this variable is not an integer, it is a word' do
        is_valid = IsValid.new
        expect(is_valid.check('hey', 'integer')).to eq(false)
      end
    end
  end
end

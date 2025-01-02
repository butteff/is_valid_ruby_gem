# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'boolean variables tests' do
      # boolean test
      it 'this variable is a boolean' do
        is_valid = IsValid.new
        expect(is_valid.check('true', 'boolean')).to eq(true)
      end

      it 'this variable is a boolean too' do
        is_valid = IsValid.new
        expect(is_valid.check('false', 'boolean')).to eq(true)
      end

      it 'this variable is a boolean as well' do
        is_valid = IsValid.new
        expect(is_valid.check('1', 'boolean')).to eq(true)
      end

      it 'this variable is a boolean again' do
        is_valid = IsValid.new
        expect(is_valid.check('0', 'boolean')).to eq(true)
      end

      it 'this variable is not a boolean, just a random word' do
        is_valid = IsValid.new
        expect(is_valid.check('random', 'boolean')).to eq(false)
      end
    end
  end
end

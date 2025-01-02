# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'email variables tests' do
      # boolean test
      it 'this variable is an email' do
        is_valid = IsValid.new
        expect(is_valid.check('butteff.ru@gmail.com', 'email')).to eq(true)
      end

      it 'this variable is an email too' do
        is_valid = IsValid.new
        expect(is_valid.check('fake-email@gmail.com', 'email')).to eq(true)
      end

      it 'this variable is not an email' do
        is_valid = IsValid.new
        expect(is_valid.check('fake-email.gmail.com', 'email')).to eq(false)
      end

      it 'this variable is not an email too' do
        is_valid = IsValid.new
        expect(is_valid.check('just a text', 'email')).to eq(false)
      end
    end
  end
end

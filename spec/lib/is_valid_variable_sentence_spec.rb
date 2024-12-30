# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'variables tests' do
      # sentence test
      it 'this variable is a sentence, returns true' do
        is_valid = IsValid.new
        expect(is_valid.check('it is a sentence to test here!', 'sentence')).to eq(true)
      end

      it 'this variable is a sentence with a comma, returns true' do
        is_valid = IsValid.new
        expect(is_valid.check('it is a sentence, something with comma to test here.', 'sentence')).to eq(true)
      end

      it 'this variable is not a sentence it is an email' do
        is_valid = IsValid.new
        expect(is_valid.check('hey@example.com', 'sentence')).to eq(false)
      end

      it 'this variable is not a sentence it is a word' do
        is_valid = IsValid.new
        expect(is_valid.check('yep', 'sentence')).to eq(false)
      end

      it 'this variable is not a sentence it is a few words without a symbol at the end' do
        is_valid = IsValid.new
        expect(is_valid.check('yep some words', 'sentence')).to eq(false)
      end

      it 'but this variable is a sentence, it is the same, but with "?" symbol at the end' do
        is_valid = IsValid.new
        expect(is_valid.check('is it valid?', 'sentence')).to eq(true)
      end

      it 'this variable is not a sentence, it is a sentense with a word' do
        is_valid = IsValid.new
        expect(is_valid.check('is sentense valid? noooo', 'sentence')).to eq(false)
      end

      it 'this variable is not a sentence, it is about two sentenses' do
        is_valid = IsValid.new
        expect(is_valid.check('is sentense valid? noooo!', 'sentence')).to eq(false)
      end
    end
  end
end

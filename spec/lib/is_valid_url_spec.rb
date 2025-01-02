# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check' do
    context 'url variables tests' do
      # url test
      it 'this variable is an url with https' do
        is_valid = IsValid.new
        expect(is_valid.check('https://butteff.ru/en/', 'url')).to eq(true)
      end

      it 'this variable is an url with https too' do
        is_valid = IsValid.new
        expect(is_valid.check('https://fake-website.com?yep=ok&ok=yep', 'url')).to eq(true)
      end

      it 'this variable is an url with http' do
        is_valid = IsValid.new
        expect(is_valid.check('http://butteff.ru/en/', 'url')).to eq(true)
      end

      it 'this variable is an url with http too' do
        is_valid = IsValid.new
        expect(is_valid.check('http://fake-website.com?yep=ok&ok=yep', 'url')).to eq(true)
      end

      it 'this variable is an url without http or https' do
        is_valid = IsValid.new
        expect(is_valid.check('butteff.ru/en/', 'url_no_http')).to eq(true)
      end

      it 'this variable is an url without http or https too' do
        is_valid = IsValid.new
        expect(is_valid.check('www.fake-website.com?yep=ok&ok=yep', 'url_no_http')).to eq(true)
      end

      it 'this variable is not an url' do
        is_valid = IsValid.new
        expect(is_valid.check('email@to-test.com', 'url')).to eq(false)
      end
    end
  end
end

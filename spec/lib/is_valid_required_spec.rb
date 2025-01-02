# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check_hash' do
    context 'required params tests' do
      # boolean test
      it 'this test full of required params to check' do
        templates = {
          settings: {
            url_required: 'url',
            site_name: 'string'
          }
        }

        hash_to_check = {
          url: 'https://butteff.ru',
          site_name: 'gem overview'
        }

        is_valid = IsValid.new({ templates: templates })
        has_url_and_name = is_valid.check_hash(hash_to_check, 'settings') # valid
        expect(has_url_and_name).to eq(true)
      end

      it 'this test full of required params to check' do
        templates = {
          settings: {
            url_required: 'url',
            site_name: 'string'
          }
        }

        hash_to_check_without_name = {
          url: 'https://butteff.ru'
        }

        is_valid = IsValid.new({ templates: templates })
        has_url = is_valid.check_hash(hash_to_check_without_name, 'settings') # valid
        expect(has_url).to eq(true)
      end

      it 'this test full of required params to check' do
        templates = {
          settings: {
            url_required: 'url',
            site_name: 'string'
          }
        }

        hash_to_check_without_url = {
          site_name: 'gem overview'
        }

        is_valid = IsValid.new({ templates: templates })
        has_name_only = is_valid.check_hash(hash_to_check_without_url, 'settings') # not valid
        expect(has_name_only).to eq(['"url" key is required in a hash'])
      end

      it 'this test full of more required params to check' do
        templates = {
          settings: {
            url_required: 'url',
            site_name_required: 'string'
          }
        }

        hash_to_check_without_url = {
          site: 'gem overview'
        }

        is_valid = IsValid.new({ templates: templates })
        has_name_only = is_valid.check_hash(hash_to_check_without_url, 'settings') # not valid
        expect(has_name_only).to eq(['"url" key is required in a hash', '"site_name" key is required in a hash'])
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check_hash' do
    context 'test hashes' do
      it 'this hash is valid' do
        templates = {
          settings: {
            url: 'url',
            is_confirmed: 'boolean',
            interval: 'integer'
          }
        }

        hash_to_check = {
          url: 'https://butteff.ru/en/',
          is_confirmed: true,
          interval: 10
        }
        is_valid = IsValid.new({ templates: templates })
        expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(true)
      end

      it 'this hash is not valid, one error' do
        templates = {
          settings: {
            url_string_key: 'url',
            is_confirmed: 'boolean',
            interval: 'integer'
          }
        }

        hash_to_check = {
          url_string_key: 'email@example.com',
          is_confirmed: true,
          interval: 10
        }
        is_valid = IsValid.new({ templates: templates })
        expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(['url_string_key is not valid, should be url'])
      end

      it 'two hashes are valid' do
        templates = {
          settings: {
            url: 'url',
            is_confirmed: 'boolean',
            interval: 'integer'
          },
          address_book: {
            email: 'email',
            url: 'url',
            name: 'words'
          }
        }

        hash_to_check = {
          url: 'https://butteff.ru/en/',
          is_confirmed: true,
          interval: 10
        }

        address_hash = {
          name: 'Sergei Illarionov',
          url: 'https://butteff.ru',
          email: 'butteff.ru@gmail.com'
        }
        is_valid = IsValid.new({ templates: templates })
        expect(is_valid.check_hash(hash_to_check, 'settings')).to eq(true)
        expect(is_valid.check_hash(address_hash, 'address_book')).to eq(true)
      end

      it 'validates hashes with own validators' do
        own_validators = {
          has_country_from_the_list: '^(Russia|USA|UAE|Brazil)$',
          can_be_an_email: '^(.)+\@(.)+$'
        }

        # define own templates (can be as many as you want inside the hash of templates):
        templates = {
          hey: {
            country: 'has_country_from_the_list',
            email: 'can_be_an_email'
          }
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates, rules: own_validators })

        # hash to check:
        hash_data = {
          country: 'Russia',
          email: 'fakemail@example.com'
        }

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(true)
      end

      it 'checks if template exists' do
        hash_data = {
          country: 'Russia',
          email: 'butteff.ru@gmail.com'
        }
        is_valid = IsValid.new
        validation = is_valid.check_hash(hash_data, 'no_template') # true or array of errors
        expect(validation).to eq(['template "no_template" with rules does not exist'])
      end

      it 'doesn\'t have some keys in the template' do
        templates = {
          hey: {
            url: 'url'
          }
        }

        # hash to check:
        hash_data = {
          url: 'https://butteff.ru/en/',
          name: 'Sergei Illarionov'
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates, all_keys: true })

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(['"name" key doesn\'t exist in the "hey" template'])
      end

      it 'test, that rule doesn\'t exist' do
        templates = {
          hey: {
            url: 'not_exist'
          }
        }

        # hash to check:
        hash_data = {
          url: 'https://butteff.ru/en/'
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates })

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(["validation rule \"not_exist\" doesn't exist"])
      end

      it 'works if key does not exist in the validation template' do
        templates = {
          hey: {
            url: 'url'
          }
        }

        # hash to check:
        hash_data = {
          url: 'https://butteff.ru/en/',
          more_value: 'test'
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates })

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(true)
      end
    end
  end
end

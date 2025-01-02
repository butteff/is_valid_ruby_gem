# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe '.check_hash' do
    context 'hash with deep levels of it\'s validation' do
      # boolean test
      it 'password error text' do
        template = {
          persons: {
            url: %w[url url_no_http],
            email: 'email',
            class: 'words',
            classmates: 'hash',
            people: 'hash',
            boys: 'hash',
            girls: 'hash'
          }
        }

        hash_to_check = {
          people: {
            url: 'https://people-fake.website.com',
            classmates: {
              boys: {
                class: 'boys class',
                email: 'fake@boysmail.com',
                url: 'www.boysclass.ru'
              },
              girls: {
                class: 'girls class',
                email: 'fake@girls-class.com',
                url: 'https://www.girls-class.ru'
              }
            }
          }
        }

        is_valid = IsValid.new({ templates: template })
        valid = is_valid.check_hash(hash_to_check, 'persons') # true
        expect(valid).to eq(true)
      end
    end
  end
end

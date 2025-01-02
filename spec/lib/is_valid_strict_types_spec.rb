# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/is_valid'

describe IsValid do
  describe 'strict types hashes unit tests' do
    context 'test hashes with strict types, symbol and constants' do
      it 'has valid strict types in a hash' do
        templates = {
          hey: {
            number_int: 'integer',
            number_float: 'float'
          }
        }

        # hash to check:
        hash_data = {
          number_int: 5,
          number_float: 555.55
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates, strict_types: true })

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(true)
      end

      it 'doesn\'t has valid strict types in a hash' do
        templates = {
          hey: {
            number_int: 'integer',
            number_float: 'float'
          }
        }

        # hash to check:
        hash_data = {
          number_int: '5',
          number_float: '555.55'
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates, strict_types: true })

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(['number_int is not valid, should be integer',
                                  'number_float is not valid, should be float'])
      end

      it 'is valid because of not enabled strict types in a hash' do
        templates = {
          hey: {
            number_int: 'integer',
            number_float: 'float'
          }
        }

        # hash to check:
        hash_data = {
          number_int: '5',
          number_float: '555.55'
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates, strict_types: false })

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(true)
      end

      it 'validates symbol and constants in a hash' do
        # module ValidatorTests
        # end
        templates = {
          hey: {
            first: 'class',
            second: 'symbol',
            third: 'array',
            forth: 'hash'
            # fifth: 'module'
          }
        }

        # hash to check:
        hash_data = {
          first: IsValid,
          second: :test,
          third: [111, 222, 333],
          forth: { aaa: 111, bbb: 222 }
          # fifth: ValidatorTests
        }

        # class initialization:
        is_valid = IsValid.new({ templates: templates, strict_types: true })

        validation = is_valid.check_hash(hash_data, 'hey') # true or array of errors
        expect(validation).to eq(true)
      end
    end
  end
end

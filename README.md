# is_valid Ruby Gem
Ruby Gem to make a validation of a variable or a hash, based on regular expressions or own predefined validation templates in an easy way.


## How to Install:

Gemfile: 
`gem 'is_valid'`

Install: 
`gem install is_valid`

## How to use:

#### check variables:

```ruby
is_valid = IsValid.new #instance creation

#variables validation:
validation = is_valid.check(1, 'integer') #true or false
validation = is_valid.check('ok, it works!', 'sentence') #true or false
```

#### check hashes:

```ruby
require 'is_valid'

#write own templates of rules (can be as many as you want inside the hash of templates)
templates = {
    settings: {
        url: 'url',
        is_confirmed: 'boolean',
        interval: 'integer',
    }
}

#instance creation:
is_valid = IsValid.new({templates: templates})

#hash to check:
hash_data = {
    url: 'https://butteff.ru/en/',
    is_confirmed: true,
    interval: 10,
}

validation = is_valid.check_hash(hash_data, 'settings') #true or array of errors
```

#### Own Validation Rules:

You can add own regular expressions to have own validators of variables:

```ruby
#define own validators to check variables (will be merged with the existed list):
own_validators = {
    has_country_from_the_list: '^(Russia|USA|UAE|Brazil)$',
    can_be_an_email: '^(.)+\@(.)+$',
}

#define own templates (can be as many as you want inside the hash of templates):
templates = {
    hey: {
        country: 'has_country_from_the_list',
        email: 'can_be_an_email',
    }
}


#instance creation:
is_valid = IsValid.new({templates: templates, rules: own_validators})

#hash to check:
hash_data = {
    country: 'Russia',
    email: 'fakemail@example.com',
}

validation = is_valid.check_hash(hash_data, 'hey') #true or array of errors

```
#### Validate a rule or nil:

You can use 'nil' rule to validate nil values:

```ruby
require 'is_valid'

#write own templates of rules (can be as many as you want inside the hash of templates)
templates = {
    settings: {
        name: 'string',
        girlfriend_name: ['string', 'nil'] #string or nil rule
    }
}

#instance creation:
is_valid = IsValid.new({templates: templates})

#hash to check:
hash_data_nil = {
    name: 'John',
    girlfriend_name: nil
}

hash_data = {
    name: 'John',
    girlfriend_name: 'Anna'
}

is_valid.check_hash(hash_data, 'settings') #valid
is_valid.check_hash(hash_data_nil, 'settings') #valid too

name_var = nil
is_valid.check(name_var, 'nil') #true
```
#### Multiple validations:

You can have multiple rules to validate. Just add it as an array of rules.
```ruby
is_valid.check('http://butteff.ru', ['email', 'url']) #true or false
````
or

```ruby
is_valid.check_one_of_rules('http://butteff.ru', ['email', 'url']) #true or an array of error texts
```

or with a hash template

```ruby
templates = {
    settings: {
        test_data: ['url', 'email'],
        is_confirmed: ['boolean', 'integer'],
        interval: ['integer', 'float']
    }
}

hash_to_check = {
    test_data: 'https://www.butteff.ru',
    is_confirmed: 'true',
    interval: '10'
}

is_valid = IsValid.new({ templates: templates })
is_valid.check_hash(hash_to_check, 'settings') #true or array full of error texts
```

#### Strict types:

You can check variables based on types of the values too, just add strict_types: true in initialize

```ruby
templates = {
    hey: {
        number_int: 'integer',
        number_float: 'float'
    }
}

# hash to check:
hash_data_types = {
    number_int: 5,
    number_float: 555.55
}

hash_data_texts = {
    number_int: '5',
    number_float: '555.55'
}

# class initialization:
is_valid = IsValid.new({ templates: templates, strict_types: true })

validation = is_valid.check_hash(hash_data_types, 'hey') # valid
validation = is_valid.check_hash(hash_data_texts, 'hey') # not valid

is_valid = IsValid.new({ templates: templates })
validation = is_valid.check_hash(hash_data_texts, 'hey') # valid, because strict_types is false
```

#### Check keys to validate in a hash:

You can check keys of your hash before a validation to know about if all the keys have rules to check.

```ruby
templates = {
    settings: {
        url: 'url'
    }
}

hash_to_check = {
    url: 'https://www.butteff.ru/en/',
    is_confirmed: 'true',
}

is_valid = IsValid.new({ templates: templates })
is_valid.check_hash(hash_to_check, 'settings') #true

is_valid = IsValid.new({ templates: templates, all_keys: true })
is_valid.check_hash(hash_to_check, 'settings') #exception ['validation rule "is_confirmed" doesn't exist']
```

#### Own Error texts:

You can have own error texts in an array of errors instead of standart texts, you can just add one more hash with these texts:

```ruby
require 'is_valid'

templates = {
    settings: {
        url: 'url',
        is_confirmed: 'boolean',
        interval: 'integer'
    }
}

hash_to_check = {
    url: 'it is not an url',
    is_confirmed: 'it is not about a boolean',
    interval: 'not an integer'
}

errors = {
    url: 'error text 1',
    is_confirmed: 'error text 2',
    interval: 'error text 3'
}
is_valid = IsValid.new({ templates: templates, errors: errors })
is_valid.check_hash(hash_to_check, 'settings') #['error text 1', 'error text 2', 'error text 3'])
```

#### Required params:

You can set keys in a template with a "\_required" at the end to have a key in a validated hash as a required one:

```ruby
require 'is_valid'

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

hash_to_check_without_name = {
    url: 'https://butteff.ru',
}

hash_to_check_without_url = {
    site_name: 'gem overview'
}

is_valid = IsValid.new({ templates: templates})
is_valid.check_hash(hash_to_check, 'settings') #valid
is_valid.check_hash(hash_to_check_without_name, 'settings') #valid
is_valid.check_hash(hash_to_check_without_url, 'settings') #not valid

```

#### initialize instance overview:

This is a short overview of initialized params:

```ruby
params = {
    templates: {}, #template of validation rules
    rules: {}, #additional own created validators
    errors: {}, #own error texts based on keys
    all_keys: false #check template to have all the same keys as a hash for a validation
    strict_types: false #strict types mode to check variable types too
}

is_valid = IsValid.new(params) #instance creation
```

## Existed Default Validators:
* integer
* float
* float_with_comma
* string
* word
* words
* sentence
* boolean
* url
* url_no_http
* email
* any
* uuid
* date_time (YYYY-MM-DD HH:MM:SS)
* date_ymd (YYYY-MM-DD)
* date_dmy: (DD.MM.YYYY)
* time_hms: (HH:MM:SS)
* time_hm: (HH:MM)
* timestamp
* password
* array
* hash
* class
* module
* symbol

## Will be in next versions

- Recursive hashes validation to validate inner hashes
- Additional pre-defined validators
- More unit tests

## Documentation of old versions

Old versions are pretty the same, but without all this new functionality, the main difference is inside an initialize.
See old documentation for the details [README_old.md file]( https://github.com/butteff/is_valid_ruby_gem/blob/main/README_old.md "README_old.md file")
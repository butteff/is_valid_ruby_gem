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
is_valid = IsValid.new(templates)

#hash to check:
hash_data = {
    url: 'https://butteff.ru/en/',
    is_confirmed: true,
    interval: 10,
}

validation = is_valid.check_hash(hash_data, 'settings') #true or array of errors
```

## Own Validation Rules:

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
is_valid = IsValid.new(templates, own_validators)

#hash to check:
hash_data = {
    country: 'Russia',
    email: 'fakemail@example.com',
}

validation = is_valid.check_hash(hash_data, 'hey') #true or array of errors

```
## Validate a rule or nil:

You can use asterics at the end of a validation rule to allow nil values:

```ruby
require 'is_valid'

#write own templates of rules (can be as many as you want inside the hash of templates)
templates = {
    settings: {
        name: 'string',
        girlfriend_name: 'string*', #string or nil rule (because of *)
    }
}

#instance creation:
is_valid = IsValid.new(templates)

#hash to check:
hash_data_nil = {
    name: 'John',
    girlfriend_name: nil
}

hash_data = {
    name: 'John',
    girlfriend_name: 'Anna'
}

validation = is_valid.check_hash(hash_data, 'settings') #valid
validation = is_valid.check_hash(hash_data_nil, 'settings') #valid too
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
* email
* any
* nil

## Will be in next versions

- Recursive hashes validation
- own error messages
- Additional validators
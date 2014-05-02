# MicroFlip

Putting the µ back into micro feature flippers. Add it to random scripts and flip it.

## Installation

Add this line to your application's Gemfile:

    gem 'micro_flip'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install micro_flip

## Usage

    Convenient version:
```
require 'micro_flip'

MicroFlip.setup

# Inside code where you want the flipping
puts "Ponies" if $flip.is_true?('pony_feature')
```

```
# Meanwhile in pry session, external script
$flip.set({'pony_feature' => 'true'})
```

Alternately, there's `bin/flip` to use from commandline:
`bundle exec flip pony_feature=true`

Or
`bundle exec bin/flip pony_feature=true pony_powerup='hot cocoa'`

If it's in your gems rather than bundle gemset
`flip pony_feature=1`

For the non-global variable implementation, see how it's done in
`bin/flip`.

## Contributing

1. Fork it ( http://github.com/zph/micro_flip/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Subshell

This gem makes it easy to run shell commands from within ruby.  It will 
raise an exception if the command fails with an unexpected exit status.  By 
default it automatically redirects STDERR to STDOUT when executing the 
command.  The return value is the output of the command with whitespace
automatically stripped.
   
Example usage:
```ruby
Subshell.exec 'echo hello world'                          # => "hello world"
Subshell.exec 'echo hello world', strip_whitespace: false # => "hello world\n"
Subshell.exec 'exit 1'                                    # => raises RuntimeError
```

## Options

|Option|Default|Description|
|------|-------|-----------|
| redirect_stderr_to_stdout | true | append 2>&1 to the command |
| expected_status | 0 | raise if the exit status of the command does not equal this value |
| strip_whitespace | true | strip whitespace from the command's output |
| logger | Rails logger (if available) or nil | log debug info, if set |
| debug | false | print debug info to STDOUT.  does not affect logger output |
| quiet | false | disable logger and STDOUT logging.  useful to suppress sensitive or verbose data from being logged |

These options can be set per call.  For convenience, the defaults can be changed with a call to Subshell.set_defaults:
 
```
Subshell.set_defaults(strip_whitespace: false)
Subshell.exec 'echo hello world'                 # => 'hello world\n'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'subshell'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install subshell

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/falconed/subshell. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


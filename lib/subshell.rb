require 'subshell/version'
require 'logger'

module Rails
end

module Subshell

  @default_options = {
      redirect_stderr_to_stdout: true,  # append 2>&1 to the command.
      expected_status: 0,               # raise if the exit status of the command does not equal this value.
      strip_whitespace: true,           # strip whitespace from the command's output.
      logger: defined?(Rails.logger) ? Rails.logger : nil,  # logger to use.  defaults to Rails logger (if available) or nil.
      debug: false,                     # print debug output to STDOUT.  does not affect logger output.
      quiet: false                      # disable logger and STDOUT logging.  useful to suppress sensitive data from being logged.
  }

  class << self

    def exec(command, options = {})
      options = @default_options.merge(options)
      output, exit_status = run_command(command, options)

      if exit_status == options[:expected_status]
        log_debug options, "Subshell.exec \"#{command}\" succeeded with output:\n#{output}"
        output
      else
        error = "Subshell.exec #{command} failed with status #{exit_status} (expected #{options[:expected_status]}):\n#{output}"
        log_error options, error
        fail error
      end
    end

    def set_defaults(options)
      @default_options.merge!(options)
    end

    private

    def run_command(command, options = {})
      log_debug options,"Subshell.exec: #{command}"
      command = "#{command} 2>&1" if options[:redirect_stderr_to_stdout]
      process = IO.popen(command, 'r')
      _pid, status = Process.wait2(process.pid)
      output = process.read
      output.strip! if options[:strip_whitespace]
      [output, status.exitstatus]
    end

    def log_message(options, level, message)
      unless options[:quiet]
        options[:logger].send(level, message) if options[:logger]
        puts message if options[:debug]
      end
    end

    def log_debug(options, message)
      log_message options, :debug, message
    end

    def log_error(options, message)
      log_message options, :error, message
    end

  end
end

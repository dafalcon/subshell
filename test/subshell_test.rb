require 'test_helper'

class SubshellTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Subshell::VERSION
  end

  def test_simple
    assert_equal 'hello world', Subshell.exec('echo hello world')
  end

  def test_raises_on_error
    assert_raises do
      Subshell.exec('exit 1')
    end
  end

  def test_expected_status
    assert_raises do
      Subshell.exec('echo hello world', expected_status: 1)
    end
  end

  def test_disable_strip_whitespace
    assert_equal "hello world\n", Subshell.exec('echo hello world', strip_whitespace: false)
  end

  def test_with_logger
    logger_filename = 'logger_test.log'
    Subshell.exec 'echo hello world', logger: Logger.new(File.open(logger_filename, 'w'))
    File.delete logger_filename
  end

end

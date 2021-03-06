require 'minitest'
require 'minitest/autorun'
require_relative '../lib/event_reporter.rb'

class EmptinessTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
  end

  def test_returns_zero_when_name_is_not_found
    skip
    reporter.find("last_name", "Johnson")
    assert_equal 0, reporter.queue_count
  end

  def test_prints_nothing_on_queue_print_when_queue_is_empty
    skip
    assert_equal '', reporter.queue_print
  end

  def test_responds_to_queue_clear_without_an_arror
    skip
    assert_raise, reporter.queue_clear
  end

  def test_test_prints_nothing_on_queue_print_by_attribute_when_queue_is_empty
    skip
    assert_equal '', reporter.queue_print(last_name)
  end

  def test_responds_to_queue_save_an_empty_file
    skip
    assert_equal '', reporter.queue_save('empty.csv')
  end

  def test_opens_an_empty_CSV_file_and_inspects_headers
    skip
    cityfile = File.open('empty.csv', r)
    assert_equal cityfile.read, reporter.inspect_headers('empty.csv')
  end

  def test_queue_count_defaults_to_zero_after_emptiness_tests
    skip
    assert_equal 0, queue_count
  end

end
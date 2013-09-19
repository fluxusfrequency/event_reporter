require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/event_reporter.rb'

class ReadingTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
    reporter.parse_input("load")
  end

  def test_responds_to_load_filename
    assert_equal 'successfully loaded event_attendees.csv', reporter.parse_input("load")
  end

  def test_responds_to_find_by_state
    reporter.parse_input("find state MD")
    assert_equal 294, reporter.parse_input("queue count")
  end

  def test_responds_to_queue_save
    skip
    assert_equal '', reporter.queue_save('state_sample.csv')
  end

  def test_quit_command
    skip
    assert_equal 'Goodbye!', reporter.quit
  end

  def test_responds_to_load_filename_after_saving
    skip
    assert_equal 'Successfully loaded state_sample.csv.', reporter.load("state_sample.csv")
  end

  def test_responds_to_find_by_first_name
    skip
    reporter.find("first_name", "John")
    assert_equal 4, reporter.queue_count
  end

end

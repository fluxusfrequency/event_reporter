require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/event_reporter.rb'

class ReadingTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
    reporter.parse_input("load")
  end

  def test_responds_to_load_filename
    reporter.parse_input("load")
    assert_equal 'successfully loaded event_attendees.csv', reporter.parse_input("load")
  end

  def test_responds_to_find_by_state
    reporter.parse_input("load")
    reporter.parse_input("find state MD")
    assert_equal 294, reporter.parse_input("queue count")
  end

  def test_responds_to_queue_save
    reporter.parse_input("load")
    reporter.parse_input("find state MD")
    reporter.parse_input("queue save state_sample.csv")
    statefile = File.open("state_sample.csv", "r")
    assert_equal "id,regdate,first_name,last_name,email_address,homephone,street,city,state,zipcode", statefile.gets.chomp
    assert_equal "7,11/12/08 16:05,Mary kate,Curry,wmppydaymaker@jumpstartlab.com,\"\",1509 Jackson Street,Baltimore,MD,21230", statefile.gets.chomp
  end

  def test_quit_command
    assert_equal "Goodbye! Event Reporter is shutting down.", reporter.parse_input("quit")
  end

  def test_responds_to_load_filename_after_saving
    assert_equal 'successfully loaded state_sample.csv', reporter.parse_input("load state_sample.csv")
  end

  def test_responds_to_find_by_first_name
    assert_equal 'successfully loaded state_sample.csv', reporter.parse_input("load state_sample.csv")
    reporter.parse_input("find first_name John")
    assert_equal 4, reporter.parse_input("queue count")
  end

end

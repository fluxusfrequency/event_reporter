require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/event_reporter.rb'

class EmptinessTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
  end

  def test_returns_zero_when_name_is_not_found
    assert_equal 0, reporter.parse_input("find last_name Johnson")
  end

  def test_queue_count_returns_0
    assert_equal 0, reporter.parse_input("queue count")
  end

  def test_prints_nothing_on_queue_print_when_queue_is_empty
    assert_equal '', reporter.parse_input("queue print")
  end

  def test_responds_to_queue_clear_without_an_arror
    assert_equal [], reporter.parse_input("queue clear")
  end

  def test_test_prints_nothing_on_queue_print_by_attribute_when_queue_is_empty
    assert_equal '', reporter.parse_input("queue print by last_name")
  end

  def test_responds_to_queue_save_an_empty_file
    reporter.parse_input("queue save empty.csv")
    emptyfile = File.open('empty.csv', "r")
    assert_equal "id,regdate,first_name,last_name,email_address,homephone,street,city,state,zipcode", emptyfile.gets.chomp
    assert_equal nil, emptyfile.gets
  end

  def test_queue_count_defaults_to_zero_after_emptiness_tests
    reporter.parse_input("queue save empty.csv")
    emptyfile = File.open('empty.csv', "r")
    assert_equal "id,regdate,first_name,last_name,email_address,homephone,street,city,state,zipcode", emptyfile.gets.chomp
    assert_equal nil, emptyfile.gets
    assert_equal 0, reporter.parse_input("queue count")
  end

end

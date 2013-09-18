###################
#
# Event Reporter
# A Jumpstart Lab Project
# Written By Ben Lewis
# gSchool[1] Student
# Completed 9/19/2013
# Blog: http://fluxusfrequency.github.io
# Twitter: @fluxusfrequency
#
###################

require 'csv'
require_relative 'finder.rb'
require_relative 'helper.rb'
require_relative 'loader.rb'
require_relative 'queuer.rb'

class EventReporter
  attr_accessor :finder, :helper, :loader, :queuer

  def initialize
    @finder = Finder.new
    @helper = Helper.new
    @loader = Loader.new
    @parts = []
    @contents = []
    @queue = []
    @command = ""
  end

  def run
    puts "
            Welcome to Event Reporter. Event Reporter helps analyze data in csv files that contain contact
            information such as names, addresses, and phone numbers. For more information, please type help.
    "

    until @command == "quit"
      printf "\n Enter command: "
      input = gets.chomp
      parse_input(input)
    end
  end

  def clean_input(input)
    input = input.downcase
  end

  def parse_input(input)
    clean_input(input)
    @parts = input.split
    parse_command(@parts[0])
  end

  def parse_command(command)
    case command
      when "load" then load
      when "queue" then queue
      when "find" then find
      when "help" then help
      when "quit"
        puts "Goodbye! Event Reporter is shutting down."
      else
        command_error
    end
  end

  def command_error
    puts "You have entered an unknown command. Please type 'help' for assistance."
  end

  def load
    if @parts[1].nil?
      @parts[1] = "event_attendees.csv"
    end
    loader.load_file(@parts[1].to_s)
  end

  def queue
    case @parts[1]
      when "count"
        puts "\nThe queue currently has #{@queue.count} items in it."
        return @queue.count
      when "clear"
        clear
        puts "\n The queue was cleared."
      when "print"
        if @parts[2] == "by"
         finder.find_by_column(@parts[3])
         print_by(@contents, @parts[3])
        else
          print
        end
      else command_error
    end
  end

  def find
    if @parts[1] == nil
      puts "\nPlease enter a column and optional criteria to find by. Type 'help find' for help."
    else
      if @parts[2] != nil
        add_to_queue_with_criteria(@parts[1].to_sym, @parts[2..-1].join(" ").to_s)
        puts "\nSuccessfully found all of the #{@parts[1].to_sym}s matching #{@parts[2..-1].join(" ").to_s}."
      else
        add_to_queue(@parts[1].to_sym)
        "\nSuccessfully found all of the #{@parts[1].to_sym}s."
      end
    end
  end

  def help
    case @parts[1]
      when "queue" then help_for_queue(@parts[2])
      when "find" then help_for_find
      when "load" then help_for_load
      else help_summary
    end
  end

  def count
    @queue.length
  end

  def clear
    @queue = []
  end

  def print
    @queue.each do |item|
      puts "#{item}"
    end
    puts queue
    puts "\nSuccessfully printed queue."
    return "successfully printed queue"
  end

  def print_by(queue, mcguffin)
    #@queue.sort!
    queue.each do |item|
      puts "#{item}"
    end
    puts "\nSuccessfully printed queue by last name."
    return "successfully printed by last name"
  end

  def add_to_queue(column)
    if column.nil?
      puts "Couldn't find any data matching the type #{column}."
      return
    end
    @contents.each do |row|
      field_name = column.to_sym
      matching_field = row[field_name].downcase
      @queue << row
    end
  end

  def add_to_queue_with_criteria(column, criteria)
    if column.nil? || criteria.nil?
      puts "Couldn't find any data matching the type #{column} or the criteria #{criteria}."
      return
    end
    @contents.each do |row|
      # What is the data in the column we are looking for?
      field_name = column.to_sym
      matching_field = row[field_name].downcase

      # if the column with the name that matches the type specified
      # equals the criteria that I am looking for
      if matching_field == criteria.downcase
      # then add this attendees data to the queue
      @queue << row
      #@queue.push Attendee.new(row)
      end
    end
  end

end

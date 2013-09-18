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

require 'pry'
require_relative 'attendee'
require_relative 'helper'
require_relative 'loader'

class EventReporter
  attr_accessor :helper, :loader

  def initialize
    @loader = Loader.new
    @parts = []
    @contents = []
    @queue = []
  end

  def run
    puts "
            Welcome to Event Reporter. Event Reporter helps analyze data in csv files that contain contact
            information such as names, addresses, and phone numbers. For more information, please type help.
    "

    until input == "quit"
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
    return "successfully loaded #{@parts[1]}"
  end

  def queue
    case @parts[1]
      when "count"
        puts "\nThe queue currently has #{count} items in it."
        return count
      when "clear"
        clear
        puts "\n The queue was cleared."
      when "print"
        if @parts[2] == "by"
         print_by
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
        @loader.contents.each do |row|
          # What is the data in the column we are looking for?
          field_name = @parts[1].to_sym
          matching_field = row[field_name].downcase
          # if the column with the name that matches the type specified
          # equals the criteria that I am looking for
          if matching_field == @parts[2..-1].join(" ").downcase

          # then add this attendees data to the queue
            @queue << row
          end
          #@queue.push Attendee.new(row)
        end
        puts "\nSuccessfully found #{count} #{@parts[1].to_sym}(s) matching #{@parts[2..-1].join(" ").to_s}."
      end
    end
  end

  def help
    @helper = Helper.new
    case @parts[1]
      when "queue" then @helper.help_for_queue(@parts[2])
      when "find" then @helper.help_for_find
      when "load" then @helper.help_for_load
      else @helper.help_summary
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
    puts "\nSuccessfully printed queue."
    return "successfully printed queue"
  end

  def print_by
    @queue.each do |item|
      puts "#{item}"
    end
    puts "\nSuccessfully printed queue by last name."
    return "successfully printed by last name"
  end

end

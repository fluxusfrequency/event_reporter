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
    @queuer = Queuer.new
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
        current_count = queuer.count(@queue)
        puts "\nThe queue currently has #{current_count} items in it."
        current_count
      when "clear"
        queuer.clear(@queue)
        puts "\n The queue was cleared."
      when "print"
        if @parts[2] == "by"
          finder.find_by_column(@parts[3])
          queuer.print_by(@contents, @parts[3])
        else
          queuer.print
        end
      else command_error
    end
  end

  def find
    if @parts[1] == nil
      puts "\nPlease enter a column and optional criteria to find by. Type 'help find' for help."
    else
      if @parts[2] != nil
        finder.find_by_criteria(@parts[1].to_sym, @parts[2..-1].join(" ").to_s)
        puts "\nSuccessfully found all of the #{@parts[1].to_sym}s matching #{@parts[2..-1].join(" ").to_s}."
      else
        finder.find_by_column(@parts[1].to_sym)
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

end

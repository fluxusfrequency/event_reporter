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
require './lib/loader.rb'
require './lib/queuer.rb'
require './lib/finder.rb'

class EventReporter
  def initialize
    puts "Event Reporter initialized!"
    @parts = []
    @queue = []
    @contents = []
  end

  def run
    puts "Welcome to Event Reporter. Event Reporter helps analyze data in csv files that contain contact
    information such as names, addresses, and phone numbers. For more information, please type help."
    command = ""
    while command != "quit"
      printf "\n Enter command: "
      input = gets.chomp
      clean_input(input)
    end
  end

  def clean_input(input)
    @parts = input.downcase.split
    parse_input(@parts)
  end

  def parse_input(input)
    command = @parts[0]
    @extension = @parts[1]
    @criteria = @parts[2..-1]
    parse_command(command)
  end

  def parse_command(command)
    case command
      when "load" then load_file(filename)
      #when "help" then helper.show_help
      when "queue" then queue_parse
      when "find" then find_parse
      when "quit"
        puts "Goodbye! Event Reporter is shutting down."
      else
        puts "You have entered an unknown command. Please type 'help' for assistance."
    end
  end

  def load_file(filename)
    @contents = CSV.open(filename, headers: true, header_converters: :symbol)
    #inspect_file(@contents)
    return "Successfully loaded #{filename}."
  end

=begin
  def inspect_file(contents)
    contents.each do |row|
      id = row[0]
      reg_date = row[:regdate]
      first_name = row[:first_name]
      last_name = row[:last_name]
      email_address = row[:email_address]
      phone_number = row[:homephone]
      street = row[:street]
      city = row[:city]
      state = row[:state]
      zipcode = row[:zipcode]
    end
  end
=end

  def queue_parse
    if @extension == "clear"
    queue_count
    end
  end

  def queue_count
    @queue.length
  end

  def find_parse
    if !@extension.nil?
      find_by(@extension, @criteria)
    end
  end

  def find_by(type, criteria)
    if @contents.nil?
      puts "Couldn't find any data matching the type #{type}."
    else
      @contents.each do |row|
        type == row[:"#{type}"]
        @queue << type unless (type != criteria)
      end
    end
  end

end

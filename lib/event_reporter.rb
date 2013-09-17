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

class EventReporter
  def initialize
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
      when "load" then load_file(@criteria.to_s)
      when "help" then help_parse
      when "queue" then queue_parse
      when "find" then find_parse
      when "quit"
        puts "Goodbye! Event Reporter is shutting down."
      else
        command_error
    end
  end

  def command_error
    puts "You have entered an unknown command. Please type 'help' for assistance."
  end

  def load_file(filename)
    @contents = CSV.open(filename, headers: true, header_converters: :symbol)
    return "Successfully loaded #{filename}."
  end

  def inspect_file(contents)
    @contents.each do |row|
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
      add_to_queue
    end
  end

  def queue_parse
    case @extension
      when "count" then queue_count
      when "clear" then queue_clear
      else command_error
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

  def find_by(column, criteria)
    if @contents.nil?
      puts "Couldn't find any data matching the type #{column}."
      return
    end
    add_to_queue(column, criteria)
  end

  def add_to_queue(column, criteria)
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

  def queue_clear
    @queue = []
  end

  def print_queue
    @queue.each do |item|
      puts "#{item[:first_name]}"
    end
  end

  def help_parse
    case @extension
      when "queue" then help_for_queue(@criteria)
      when "find" then help_for_find
      when "load" then help_for_load
      else help_summary
    end
  end

  def help_for_load
    puts "*** Load Help ***\n\n"
    puts "load <filename.csv>: loads the specified file into EventReporter.\n"
  end

  def help_for_find
    puts "*** Find Help ***\n\n"
    puts "find <column> <criteria>: searches the loaded csv file for all rows matching the given column and adds them to the queue if they match the criteria.\n"
    puts "Typical column names found in csv files include first_name, last_name, phone_number, email_address, city, and state."
  end


  def help_for_queue(command = "default")
    help_queue_messages = { :count => "queue count: Reports the number of records that matched the last search.", :clear => "queue clear: Clears the search result queue.", :print => "queue print: Prints a table showing the data in the result queue.", :print_by => "queue print by <column>: Prints a table sorted by the specified column name.", :save => "queue save to <filename.csv>: Exports the current queue to the specified filename."}
    case command
      when "count"
        puts help_queue_messages[:count]
      when "clear"
        puts puts help_queue_messages[:clear]
      when "print" && (!@parts[2] == "by")
        puts help_queue_messages[:print]
      when "print" && (@parts[2] == "by")
        puts puts help_queue_messages[:print_by]
      when "save"
        puts
        puts help_queue_messages[:save]
      else
        puts "*** Queue Help ***\n\n"
        help_queue_messages.values.each do |message|
          puts "    #{message}\n"
        end
    end
  end

  def help_summary
    help_messages = { :load => "load <filename.csv>: loads the specified file into EventReporter", :find => "find <column> <criteria>: searches the loaded csv file for all rows matching the given column and adds them to the queue if they match the criteria", :queue => "queue <subcommand>: accesses and manipulates the queue of found data"}
    puts "*** EventReporter Help ***\n\n"
    puts "
    Event Reporter helps analyze data in csv files that contain contact
    information such as names, addresses, and phone numbers. To get started,
    use the 'load' command to load a csv file. Then, use 'find' to sort data by
    a column name from the CSV (such as: 'first_name'). The found data will be
    stored in a 'queue'. You can access and perform operations on the queue using
    the 'queue' command.\n\n"


    puts "*** Commands ***\n\n"
    help_messages.values.each do |message|
      puts "    #{message}\n"
    end

    puts "\n
    Type 'help <command>' to read more about a specific command."
    return "responded to help"
  end


end

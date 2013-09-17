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
      parse_input(input)
    end
  end

  def clean_input(input)
    input = input.downcase
  end

  def parse_input(input)
    clean_input(input)
    @parts = input.split
    command = @parts[0]
    @extension = @parts[1]
    @subcommand = @parts[2]
    @find_criteria = @parts[2..-1]
    @mcguffin = @parts[3..-1]
    parse_command(command)
  end

  def parse_command(command)
    case command
      when "load"
        if @extension.nil?
          @extension = "event_attendees.csv"
        end
        load_file(@extension.to_s)
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
    @contents = []
    @contents = CSV.open(filename, headers: true, header_converters: :symbol)
    return "Successfully loaded #{filename}."
  end

  def queue_parse
    case @extension
      when "count" then queue_count
      when "clear" then queue_clear
      when "print"
        if @subcommand == "by"
          queue_print_by_mcguffin
        else
          queue_print
        end
      else command_error
    end
  end

  def queue_count
    @queue.length
  end

  def queue_clear
    @queue = []
  end

  def queue_print
    @queue.each do |item|
      puts "#{item[:first_name]}"
    end
    return "successfully printed queue"
  end

  def queue_print_by_mcguffin
    find_by_column(@mcguffin)
    @queue.each do |item|
      puts "#{item[@print_by_criteria.to_sym]}"
    end
    @queue.sort {|x,y| x <=> y }
    return "successfully printed by last name"
  end

  def add_to_queue(column)
    queue_clear
    @contents.each do |row|
      field_name = column.to_sym
      matching_field = row[field_name].downcase
      @queue << row
    end
  end

  def add_to_queue_with_criteria(column, criteria)
    queue_clear
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

  def find_parse
    if @extension
      if @find_criteria
        find_by_criteria(@extension.to_sym, @find_criteria.join(" ").to_s)
      else
        find_by_column(@extension.to_sym)
      end
    else
      puts "Please enter a column and optional criteria to find by. Type 'help find' for help."
    end
  end

  def find_by_column(column)
    #if column.nil?
    #  puts "Couldn't find any data matching the type #{column}."
    #  return
    #end
    add_to_queue(column)
  end

  def find_by_criteria(column, criteria)
    #if @contents.nil?
    #  puts "Couldn't find any data matching the type #{column} or the criteria #{criteria}."
    #  return
    #end
    add_to_queue_with_criteria(column, criteria)
  end

  def help_parse
    case @extension
      when "queue" then help_for_queue(@subcommand)
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


  def help_for_queue(subcommand = "none")
    help_queue_messages = { :count => "queue count: Reports the number of records that matched the last search.", :clear => "queue clear: Clears the search result queue.", :print => "queue print: Prints a table showing the data in the result queue.", :print_by => "queue print by <column>: Prints a table sorted by the specified column name.", :save => "queue save to <filename.csv>: Exports the current queue to the specified filename."}
    case subcommand
      when "count"
        puts help_queue_messages[:count]
        return "responded to help queue count"
      when "clear"
        puts puts help_queue_messages[:clear]
      when "print"
        if @parts[3] == "by"
          puts help_queue_messages[:print_by]
        else
          puts help_queue_messages[:print]
        end
        return "responded to help queue print"
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

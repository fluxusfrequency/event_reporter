class Helper

  def help_parse
    case @parts[1]
      when "queue" then help_for_queue(@parts[2])
      when "find" then help_for_find
      when "load" then help_for_load
      else help_summary
    end
  end

  def help_for_load
    puts "\n*** Load Help ***\n\n"
    puts "load <filename.csv>: loads the specified file into EventReporter.\n"
  end

  def help_for_find
    puts "\nq*** Find Help ***\n\n"
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
        puts help_queue_messages[:print]
        puts help_queue_messages[:print_by]
        return "responded to help queue print"
      when "save"
        puts
        puts help_queue_messages[:save]
      else
        puts "\n*** Queue Help ***\n\n"
        help_queue_messages.values.each do |message|
          puts "    #{message}\n"
        end
    end
  end

  def help_summary
    help_messages = { :load => "load <filename.csv>: loads the specified file into EventReporter", :find => "find <column> <criteria>: searches the loaded csv file for all rows matching the given column and adds them to the queue if they match the criteria", :queue => "queue <subcommand>: accesses and manipulates the queue of found data"}
    puts "\n*** EventReporter Help ***\n\n"
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

class Helper

  def help_for_load
    puts "\n\t\t*** Load Help ***\n\n"
    puts "\n\t\tload <filename.csv>: loads the specified file into EventReporter.\n"
  end

  def help_for_find
    puts "\n\t\tq*** Find Help ***\n\n"
    puts "\n\t\tfind <column> <criteria>: searches the loaded csv file for all rows
    \t\tmatching the given column and adds them to the queue if they match the criteria.\n"
    puts "\n\t\tTypical column names found in csv files include first_name, last_name, phone_number, email_address, city, and state."
  end


  def help_for_queue(subcommand = "none")
    help_queue_messages = { :count => "\n\t\tqueue count: Reports the number of records that matched the last search.", :clear => "\n\t\tqueue clear: Clears the search result queue.", :print => "\n\t\tqueue print: Prints a table showing the data in the result queue.", :print_by => "\n\t\tqueue print by <column>: Prints a table sorted by the specified column name.", :save => "\n\t\tqueue save to <filename.csv>: Exports the current queue to the specified filename."}
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
          puts "#{message}"
        end
    end
  end

  def help_summary
    help_messages = { :load => "\n\t\tload <filename.csv>: loads the specified file into EventReporter", :find => "\n\t\tfind <column> <criteria>: searches the loaded csv file for all rows \n\t\tmatching the given column and adds them to the queue if they match the criteria", :queue => "\n\t\tqueue <subcommand>: accesses and manipulates the queue of found data"}
    puts "\n\t\t*** EventReporter Help ***\n\n"
    puts "\n\t\tEvent Reporter helps analyze data in csv files that contain contact
    \t\tinformation such as names, addresses, and phone numbers. To get started,
    \t\tuse the 'load' command to load a csv file. Then, use 'find' to sort data by
    \t\ta column name from the CSV (such as: 'first_name'). To figure out the valid
    \t\tsearch terms, read the headers in the CSV file you want to search. The found
    \t\tdata will be stored in a 'queue'. You can access and perform operations on the
    \t\tqueue using the 'queue' command.\n\n"


    puts "\n\t\t*** Commands ***\n\n"
    help_messages.values.each do |message|
      puts "#{message}\n"
    end

    puts "\n\t\tType 'help <command>' to read more about a specific command."
    return "responded to help"
  end


end

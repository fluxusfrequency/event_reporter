class Helper

  def help_for_load
    return "*** Load Help ***\n\n
    \n\t\tload <filename.csv>: loads the specified file into EventReporter.\n"
  end

  def help_for_find
    return "\n\t\tq*** Find Help ***\n\n
          \n\t\tfind <column> <criteria>: searches the loaded csv file for all rows
          \t\tmatching the given column and adds them to the queue if they match the criteria.
          \t\tThe columns found in the defaul csv file include id, reg_date, first_name, last_name,
          \t\temail, phone, street, city, state, and zipcode.\n\n"
  end


  def help_for_queue(subcommand = "none")
    help_queue_messages = { :count => "queue count: Reports the number of records that matched the last search.", :clear => "queue clear: Clears the search result queue.", :print => "queue print: Prints a table showing the data in the result queue.", :print_by => "queue print by <column>: Prints a table sorted by the specified column name.", :save => "queue save to <filename.csv>: Exports the current queue to the specified filename."}
    case subcommand
      when "count"
        return help_queue_messages[:count]
      when "clear"
        return help_queue_messages[:clear]
      when "print"
        return "#{help_queue_messages[:print]}/n#{help_queue_messages[:print_by]}"
      when "save"
        return help_queue_messages[:save]
      else
        puts "\n*** Queue Help ***\n\n"
        help_queue_messages.values.each do |message|
          puts "#{message}"
        end
    end
  end

  def summarize_help
    return help_summary + help_command_summary
  end

  def help_command_messages
    { :load => "\n\t\tload <filename.csv>: loads the specified file into EventReporter", :find => "\n\t\tfind <column> <criteria>: searches the loaded csv file for all rows \n\t\tmatching the given column and adds them to the queue if they match the criteria", :queue => "\n\t\tqueue <subcommand>: accesses and manipulates the queue of found data"}
  end

  def help_summary
    return "\n\t\t*** EventReporter Help ***\n\n
    \n\t\tEvent Reporter helps analyze data in csv files that contain contact
    \t\tinformation such as names, addresses, and phone numbers. To get started,
    \t\tuse the 'load' command to load a csv file. Then, use 'find' to sort data by
    \t\ta column name from the CSV (such as: 'first_name'). To figure out the valid
    \t\tsearch terms, read the headers in the CSV file you want to search. The found
    \t\tdata will be stored in a 'queue'. You can access and perform operations on the
    \t\tqueue using the 'queue' command.\n\n"
  end

  def help_command_summary
    help_command_stack = []
    help_command_messages.values.each do |message|
      help_command_stack << "#{message}\n"
    end
    command_stack_for_return = help_command_stack.join("\n")

    return "\n\t\t*** Commands ***\n\n
    #{command_stack_for_return}
    Type 'help <command>' to read more about a specific command."
  end


end

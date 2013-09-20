class Printer

  def print(queue)
    create_tabs
    print_lines(queue)
    if queue.length == 0
      puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
      return ''
    else
      puts "\n\t\tSuccessfully printed #{queue.length} queue items."
      return "successfully printed #{queue.length} queue items"
    end
  end

  def print_by(queue, param)
    create_tabs
    queue = queue.sort_by {|attendee| attendee[param.downcase.to_sym]}
    print_lines(queue)
    if queue.length == 0
      puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
      return ''
    else
      puts "\n\t\tSuccessfully printed #{queue.length} queue items by #{param}."
      return "successfully printed #{queue.length} queue items by #{param}"
    end
  end

  def create_tabs
    puts "--------------------------------------------------------------------------------------------------------------------------------------------"
    puts "ATTENDEE ID   REG DATE      FIRST NAME    LAST NAME     EMAIL         PHONE         ADDRESS       CITY          STATE         ZIPCODE       "
    puts "--------------------------------------------------------------------------------------------------------------------------------------------"
  end

  def print_lines(queue)
    queue.each do |item|
      item.values.each do |value|
        if value.nil?
          value = " "
        end
        value = value[0..12]
        lvalue = value.ljust(14, " ")
        printf "#{lvalue}"
      end
      puts ""
    end
  end

  def print_error_for(command)
    case command
      when ""

      when "save"
        puts "\n\t\tPlease enter a filename to save to. Type 'help queue save' for more information."
      when "find"
        puts "\n\t\tPlease enter a column and criteria to find by. Type 'help find' for help."
      else
        command_error
    end
  end

  def command_error
    puts "\n\t\tSorry, EventReporter couldn't recognize your command.
    \t\tPlease type 'help' if you need assistance."
  end

  def welcome_message
    "Welcome to Event Reporter. Event Reporter
     \t\thelps analyze data in csv files that contain contact
     \t\tinformation such as names, addresses, and phone numbers.
     \t\tFor more information, please type help."
  end

  def goodbye_message
    "Goodbye! Event Reporter is shutting down.\n\n"
  end

end

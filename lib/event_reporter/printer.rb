class Printer

  def print(queue)
    if queue.length == 0
      return empty_queue_error_message
    end

    return "#{create_tabs}#{print_lines(queue)}#{successful_print_message(queue.length)}"
  end

  def print_by(queue, param)
    if queue.length == 0
      return empty_queue_error_message
    end

    param = clean_param_for_sort(param)
    queue = queue.sort_by {|attendee| attendee[param]}
    return "#{create_tabs}#{print_lines(queue)}#{successful_print_by_message(queue.length, param)}"
  end

  def clean_param_for_sort(param)
    param.downcase.to_sym
  end

  def create_tabs
    return "--------------------------------------------------------------------------------------------------------------------------------------------\nATTENDEE ID   REG DATE      FIRST NAME    LAST NAME     EMAIL         PHONE         ADDRESS       CITY          STATE         ZIPCODE       \n--------------------------------------------------------------------------------------------------------------------------------------------"
  end

  def print_lines(queue)
    ljusted_values = queue.each do |attendee|
      attendee.values.collect do |value|
        clean_attendee_values(value)
      end
    end
    ## I think I broke it. Checkout an older version and fix.

    return "#{ljusted_values}#{successful_print_message(queue.length)}"
  end

  def clean_attendee_value(value)
    value ||= " "
    value = value[0..12]
    lvalue = value.ljust(14, " ")
    return lvalue
  end

  def print_error_for(command)
    case command
      when "save" then return save_error
      when "find" then return find_error
      when "print" then return print_error
      else return command_error
    end
  end

  def save_error
    return "Please enter a filename to save to. Type 'help queue save' for more information."
  end

  def find_error
    return "Please enter a column and criteria to find by. Type 'help find' for help."
  end

  def print_error
    return "Sorry, there was a problem with your command. Type 'help queue print' for help."
  end

  def command_error
    return "Sorry, EventReporter couldn't recognize your command.\n\t\tPlease type 'help' if you need assistance."
  end

  def welcome_message
    return "Welcome to Event Reporter. Event Reporter
     \t\thelps analyze data in csv files that contain contact
     \t\tinformation such as names, addresses, and phone numbers.
     \t\tFor more information, please type help."
  end

  def goodbye_message
    return "Goodbye! Event Reporter is shutting down.\n\n"
  end

  def empty_queue_error_message
    return "Print was unsuccessful because the queue was empty. Try running 'load' followed by a 'find' command first."
  end

  def successful_print_message(count)
    return "Successfully printed #{count} queue items."
  end

  def successful_print_by_message(count, param)
    return "Successfully printed #{count} queue items by #{param}."
  end

end

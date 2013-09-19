class Printer
  # def initialize
  # end

  def print(queue)
    queue.each do |item|
      puts "#{item}"
    end
    if queue.length == 0
      puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
      return ''
    else
      puts "\n\t\tSuccessfully printed #{queue.length} queue items."
      return "successfully printed #{queue.length} queue items"
    end
  end

  def print_by(queue, param)
    queue = queue.sort_by {|attendee| attendee[param.downcase.to_sym]}
    queue.each do |item|
      puts "#{item}"
    end
    if queue.length == 0
      puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
      return ''
    else
      puts "\n\t\tSuccessfully printed #{queue.length} queue items by #{param}."
      return "successfully printed #{queue.length} queue items by #{param}"
    end
  end

end

class Queuer
  def count(queue)
    queue.length
  end

  def clear(queue)
    queue = []
  end

  def print(queue)
    queue.each do |item|
      puts "#{item}"
    end
    puts queue
    puts "\nSuccessfully printed queue."
    return "successfully printed queue"
  end

  def print_by(queue, mcguffin)
    #@queue.sort!
    @queue.each do |item|
      puts "#{item}"
    end
    puts "\nSuccessfully printed queue by last name."
    return "successfully printed by last name"
  end

  def add_to_queue(column)
    @contents.each do |row|
      field_name = column.to_sym
      matching_field = row[field_name].downcase
      @queue << row
    end
  end

  def add_to_queue_with_criteria(column, criteria)
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
end

class Finder

  def find_by_column(column)
    if column.nil?
      puts "Couldn't find any data matching the type #{column}."
      return
    end
    add_to_queue(column)
  end

  def find_by_criteria(column, criteria)
    if column.nil? || criteria.nil?
      puts "Couldn't find any data matching the type #{column} or the criteria #{criteria}."
      return
    end
    add_to_queue_with_criteria(column, criteria)
  end

end

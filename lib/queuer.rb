class Queuer
  def initialize
    @queue = []
  end

  def count
    @queue.length
  end

  def clear
    @queue = []
  end
end

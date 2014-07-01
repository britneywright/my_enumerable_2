module MyEnumerable
  def count
    count = 0
    self.each {count += 1}
    count
  end

  def find
    self.each do |element|
      if yield(element)
        return element
      end
    end
    return nil
  end

  def select
    ary = []
    self.each do |element|
      if yield(element)
        ary << element
      end
    end
    ary
  end

  def map
    ary = []
    self.each do |element|
      ary << yield(element)
    end
    ary
  end

  def first
    self.each do |element|
      return element
    end
    return nil
  end

  def min
    smallest = self.first
    self.each do |element|
      if element < smallest
        smallest = element
      end
    end
    smallest
  end

  def include?(target)
    self.each do |element|
      if element == target
        return true
      end
    end
    return false
  end

  def min_by
    smallest = yield(self.first)
    value = self.first
    self.each do |element|
      if yield(element) < smallest
        smallest = yield(element)
        value = element
      end
    end
    value
  end

  def all?(&block)
    return !select { |e| e } unless block
    !find { |e| !yield(e) } 
  end

  def take(target)
    ary = []
    count = 0
    self.each do |element|
      count += 1
      if count <= target
        ary << element
      end
    end
    ary
  end

  def any?(&block)
    block ||= lambda {|e| e}
    !!find(&block)
  end

  def none?(&block)
    block ||= lambda { |e| e}
    !find(&block)
  end
end

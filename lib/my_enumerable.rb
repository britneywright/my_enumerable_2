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
end
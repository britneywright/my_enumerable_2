module MyEnumerable
  def count
    count = 0
    self.each {count += 1}
    count
  end
end
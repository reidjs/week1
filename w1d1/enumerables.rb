class Array
  def my_each(&prc)
    self.length.times do |ele|
      prc.call(self[ele])
    end
    self
  end

  def my_select(&prc)
    arr = []
    my_each do |ele|
      arr << ele if prc.call(ele)
    end
    arr
  end

  def my_reject(&prc)
    arr = []
    my_each do |ele|
      arr << ele if !prc.call(ele)
    end
    arr
  end

  def my_any?(&prc)
    my_each do |ele|
      return true if prc.call(ele)
    end
    false
  end

  #alternate confusing double negative method
  # def my_all?(&prc)
  #   my_each do |ele|
  #     return false if !prc.call(ele)
  #   end
  #   true
  # end

  def my_all?(&prc)
    my_each do |ele|
      return false unless prc.call(ele)
    end
    true
  end

  # def my_flatten
  #   str = ''
  #   my_each do |ele|
  #     if ele.is_a?(Array)
  #       # p ele.my_flatten
  #       str << ele.my_flatten
  #     else
  #       str << ele.to_s
  #     end
  #   end
  #   # str.chars.my_each { |c| c.to_i }
  #   str
  # end

  def my_flatten
    arr = []
    my_each do |ele|
      if ele.is_a?(Array)
        # p ele.my_flatten
        arr.concat(ele.my_flatten)
      else
        arr << ele
      end
    end

    # str.chars.my_each { |c| c.to_i }
    arr
  end

  def my_zip(*args)
    result = []
    self.each_index do |i|
      inner = []
      inner << self[i]
      args.each_index do |j|
        inner << args[j][i]
      end
      result << inner
    end

    result
  end

  def my_rotate(val = 0)
    # arr = []
    # left = self[0...val]
    # right = self[val..-1]
    val = (self.length + val) % self.length if val < 0
    val = val % self.length if val > self.length
    right = self.drop(val)
    left = self.take(val)
    right + left
  end

  def my_join(sep = "")
    str = ""
    self.each_index do |i|
      str << self[i]
      str << sep if i < self.length - 1
    end
    str
  end

  def my_reverse
    arr = []
    i = self.length - 1
    while i >= 0
      arr << self[i]
      i -= 1
    end
    arr
  end
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"
# a = [ "a", "b", "c", "d" ]
# a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

#my all and my any tests
# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# my each test
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
#
# p return_value

# #my select test
# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []
#my reject test
# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

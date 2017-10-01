#using remove, replace, and insert, determine if a string is
#0 or 1 edit away from a desired result

require 'byebug'

def remove(str, idx)
  str = str.dup
  str[idx] = ""
  str
end

def insert(str, idx, chr)
  str = str.dup
  str.insert(idx, chr)
  str
end

def replace(str, idx, chr)
  str = str.dup
  str[idx] = chr
  str
end

def iterate(str, prc)
  str = str.dup
  str.each_index do |i|
    str[i] = prc.call
  end
end


#create a method that will take every index of the string and apply the relevent
#operation, like remove, insert, etc.

def edits_required(string, desired)
  return 0 if string == desired

end

def remove_chars(string)

end

def loop_through_indices(string, prc)
  i = 0
  while i < string.length
    prc.call(string, i)
    i += 1
  end
  string
end



def each_letter
  letters = ('a'..'z').to_a
  letters.each do |l|
    yield l
  end
end

def check_string(string, desired = "pale")
  string == desired
end

replace = Proc.new do |str, idx|
  orig_letter = str[idx]
  each_letter do |l|
    orig_letter != l ? str[idx] = l : next
    break if check_string(str)
  end
  check_string(str) ? break : str[idx] = orig_letter
end
string = "pable"
replace.call(string, 2)
p string


#
# class LinkedListAlphabet
#   attr_accessor :nodes
#   def initialize
#     nodes = []
#     letters = ('a'..'z').to_a
#     letters.each do |l|
#
#     end
#   end
#
#   def node(val, next_node)
#     next_node = nil
#     value = val
#   end
# end



# p loop_through_indices("hello", replace)

#
# x = "hello"
# p remove(x, 0)
# p insert(x, 3, "B")
# p replace(x, 3, "B")
# p x

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
  check_string(str) ? str : str[idx] = orig_letter
end

remove = Proc.new do |str, idx|
  orig_string = str.dup
  str[idx] = ""
  check_string(str) ? str : orig_string
end


# string = "paze"
# # replace.call(string, 2)
# string = remove.call(string, 1)
# p string

#TO DO: Now try to make these methods so they ONLY do the logic



# test_remove = "pabble"
# p remove2.call(test_remove.dup, 2)
#
#
#
# test_replace = "paze"
#
# each_letter do |l|
#   break if replace2.call(test_replace.dup, 2, l)
# end
#
#
#
# test_insert = "pae"
# each_letter do |l|
#   break if insert2.call(test_insert.dup, 1, l)
# end


def oneaway(string, desired = "pale")
  remove = Proc.new do |str, idx|
    str[idx] = ""
    str
  end

  replace = Proc.new do |str, idx, l|
    str[idx] = l if idx < str.length
    str
  end

  insert = Proc.new do |str, idx, l|
    idx <= str.length ? str.insert(idx, l) : str << l
    str
  end

  i = 0
  while i <= string.length
    return true if check_string(remove.call(string.dup, i))
    each_letter do |l|
      return true if check_string(replace.call(string.dup, i, l), desired)
      return true if check_string(insert.call(string.dup, i, l), desired)
    end
    i += 1
  end
  false
end

p oneaway("palezd", "pale")


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

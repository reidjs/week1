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

rm = Proc.new do |c|
  c = ""
end



#create a method that will take every index of the string and apply the relevent
#operation, like remove, insert, etc.

def edits_required(string, desired)
  return 0 if string == desired

end

def remove_chars(string)

end

def loop_through_indices(string, &prc)

end



x = "hello"
p remove(x, 0)
p insert(x, 3, "B")
p replace(x, 3, "B")
p x

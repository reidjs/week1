#given two strings, write method to determine if one is permut. of the other

class String

  def check_permutation(s)
    h1 = hash_string_chars(self)
    h2 = hash_string_chars(s)
    p h1
    p h2
    h1.keys.each do |k|
      return false if h2[k] != h1[k]
    end
    true
  end

  def hash_string_chars(s)
    h = {}
    s.chars.each do |c|
      h[c].nil? ? (h[c] = 1) : (h[c] += 1)
    end
    h
  end
end
p "hello".check_permutation("ohlle")

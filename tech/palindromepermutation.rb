#function to check if a string is permutation of a palindrome
#to be a palindrome, there must be an equal number of letters and one extra
def palindrome_permutation?(string)
  string.gsub!(" ", "")
  h = generate_hash(string.downcase)
  odds = 0
  h.each_value do |v|
    odds += 1 if v == 1
  end
  return true if odds == 0 && string.length.even?
  return true if odds == 1 && string.length.odd?
  false
end

def generate_hash(string)
  h = {}
  string.chars.each do |c|
    h[c].nil? ? h[c] = 1 : h[c] += 1
  end
  h
end

p palindrome_permutation?("Tact coa")

#replace all spaces in string with %20. Assume string has enough space
# to hold chars, and given true length of string
#input: "Mr John Smith    ",13
#output: "Mr%20John%20Smith"

input = "Mr John Smith sdf  "
length = input.length

def urlify(string)
  string.strip.chomp.gsub(" ", "%20")
end

p urlify(input)

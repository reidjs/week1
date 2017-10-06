#compress repeated letters in a string to a number after letter
#e.g., aaa = 3a, bbccd = 2b2c1d
string = "aaaabbcddafffffffzzzzfzzzzz"
compressed = ""
i = 0
count = 1
while i < string.length
  if string[i] == string[i + 1]
    count += 1
  else
    compressed << count.to_s
    compressed << string[i]
    count = 1
  end
  i += 1
end
compressed.length < string.length ? (p compressed) : (p string)

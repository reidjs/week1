require 'byebug'
#input: decimal e.g. 5
#output: binary array e.g. [1,0,1]
def dec_to_bin_array(dec_num)
  #turn into array of string chars
  bin = dec_num.to_s(2).chars
  #convert to integers
  bin.map(&:to_i)
end

#input: two arrays of 0s and 1s
#insert leading zeros to beginning of shorter array to equalize length
def equalize_length(arr1, arr2)
  while arr1.length < arr2.length
    arr1.unshift(0)
  end
  while arr2.length < arr1.length
    arr2.unshift(0)
  end
end

#input: bit1, bit2, amount to carry
#output: [digit to carry over, digit to insert to end of sum]
def add_bits(bit1, bit2, carry)
  # p "bit1: #{bit1}, bit2: #{bit2}, carry: #{carry}"
  return [1, 1] if bit1 == 1 && bit2 == 1 && carry == 1
  return [1, 0] if (bit1 == 1 || bit2 == 1) && carry == 1
  return [0, 1] if (bit1 == 0 && bit2 == 0) && carry == 1
  return [1, 0] if bit1 == 1 && bit2 == 1 && carry == 0
  return [0, 1] if (bit1 == 1 || bit2 == 1) && carry == 0
  [0, 0]
end


def add_binary_arrays(arr1, arr2)
  # byebug
  sum = []
  equalize_length(arr1, arr2)
  carry_digit = 0
  while !arr1.empty?
    m = arr1.pop
    n = arr2.pop
    v = add_bits(m, n, carry_digit)
    carry_digit = v[0]
    sum.unshift(v[1])
  end
  # sum.unshift(0)
  sum.unshift(carry_digit)
  sum
end

#input: two base10 numbers
#output: their sum :)
def add_two_numbers_using_bitwise_operations(a, b)
  m = dec_to_bin_array(a)
  n = dec_to_bin_array(b)
  # p "m: #{m}, n: #{n}"
  v = add_binary_arrays(m, n)
  # p "v: #{v}"
  bin_array_to_dec10(v)
end

def bin_array_to_dec10(arr, n = 0, pow = 0)
  return n if arr.empty?
  n += arr.pop * (2**pow)
  bin_array_to_dec10(arr, n, pow + 1)
end



# num1 = 5.to_s(2).chars
# num2 = 889.to_s(2).chars
# a = num1.map(&:to_i)
# b = num2.map(&:to_i)
# a = dec_to_bin_array(5)
# b = dec_to_bin_array(8)
# # equalize_length(a, b)
# p a
# p b
# p bin_array_to_dec10(b)

# p add_binary_arrays(a, b)
p add_two_numbers_using_bitwise_operations(9, 5) == 14
p add_two_numbers_using_bitwise_operations(32, 9) == 41
p add_two_numbers_using_bitwise_operations(41, 1) == 42
p add_two_numbers_using_bitwise_operations(104, 10) == 114
# p add_bits(1,0, 0)

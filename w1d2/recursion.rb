# Write a function sum_to(n) that uses recursion to calculate the sum
#from 1 to n (inclusive of n).

def sum_to(n)
  # p n
  return n if n == 0
  return nil if n < 0
  n += sum_to(n-1)
end 

# sum_to Test Cases
p sum_to(5) == 15 # => returns 15
p sum_to(1) == 1  # => returns 1
p sum_to(9) == 45  # => returns 45
p sum_to(-8) == nil # => returns nil

#Write a function add_numbers(nums_array) that takes in an array of F
#ixnums and returns the sum of those numbers. Write this method recursively.
def add_numbers(arr)
  return arr[0] if arr.length <= 1
  arr[0] += add_numbers(arr[1..-1])
end

# add numbers Test Cases
p add_numbers([1,2,3,4]) == 10# => returns 10
p add_numbers([3]) == 3# => returns 3
p add_numbers([-80,34,7]) == -39# => returns -39
p add_numbers([]) == nil # => returns nil

#Let's write a method that will solve Gamma Function recursively.
# The Gamma Function is defined f(n) = (n-1)!.
def gamma_fnc(n)
  return n if n == 1
  return nil if n < 1
  n -= 1
  return n if n <= 1
  n * gamma_fnc(n)
end

# gamma fnc Test Cases
p gamma_fnc(0) == nil # => returns nil
p gamma_fnc(1) == 1  # => returns 1
p gamma_fnc(4) == 6  # => returns 6
p gamma_fnc(5) == 24  # => returns 24
p gamma_fnc(8) == 5040 # => returns 5040

# Write a function ice_cream_shop(flavors, favorite) that takes in an array
# of ice cream flavors available at the ice cream shop, as well as the user's
#  favorite ice cream flavor. Recursively find out whether or not the shop offers
#   their favorite flavor.

def ice_cream_shop(arr, desired)
  flavor = arr.pop
  return true if flavor == desired
  return false if arr.empty?
  ice_cream_shop(arr, desired)
end

# Test Cases
p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon') == false # => returns false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea') == true # => returns true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio') == false  # => returns false
p ice_cream_shop(['moose tracks'], 'moose tracks') == true  # => returns true
p ice_cream_shop([], 'honey lavender')  == false # => returns false

# Write a function reverse(string) that takes in a string and returns it reversed.

def reverse(string)
  return "" if string.empty?
  return string[-1] if string[0...-1].empty?
  string[-1] + reverse(string[0...-1])
  # return string if string

end

# Test Cases
p reverse("house")# => "esuoh"
p reverse("dog") # => "god"
p reverse("atom") # => "mota"
p reverse("q") # => "q"
p reverse("id") # => "di"
p reverse("") # => ""

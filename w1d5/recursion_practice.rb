#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  sum = array[0] + sum_recur(array[1..-1])
  sum
end
# p sum_recur([2,4,1])

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.empty?
  return true if array[0] == target
  includes?(array[1..-1], target)
end
# p includes?([4,2,3], -1)
# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  sum = 0
  sum += 1 if array[0] == target
  sum + num_occur(array[1..-1], target)
end
# p num_occur([0,3,5,2,2], 0)

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length < 2
  return true if array[0] + array[1] == 12
  add_to_twelve?(array[1..-1])

end
# p add_to_twelve?([4,2,5,6])
# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted small to large.

def sorted?(array)
  return true if array.length < 2
  return false if array[0] > array[1]
  sorted?(array[1..-1])
end

# p sorted?([2,4,5, 3])

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return string if string.length < 2
  string.chars.last + reverse(string[0...-1])
end
p reverse("hello")

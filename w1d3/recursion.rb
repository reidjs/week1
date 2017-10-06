#Returns the range recursively
#ex: range(1, 5) => [1, 2, 3, 4]
def range(first, last)
  return [] if first > last
  return [first] if last - first == 1
  arr = [first] + range(first + 1, last)
  arr[0..-1]
end

#Returns exponent recursively, does not work for negative powers
#ex: exponent(2, 3) => 8
def exponent(base, power)
  return 1 if power == 0
  # if n < 0
  #   return (b * (1.0 / exp1(b, n + 1)))
  # end
  smaller_exponent = power - 1
  base_to_the_smaller_exponent = exponent(base, smaller_exponent)
  base * base_to_the_smaller_exponent
end

#Different implementation of exponent recursively
def exponent2(base, power)
  return 1 if power == 0
  return base if power == 1
  if power.even?
    return exponent2(base, power / 2) * exponent2(base, power / 2)
  end
  base * (exponent2(base, (power - 1) / 2) * exponent2(base, (power - 1) / 2))
end

#A method on array that creates a memory copy (not reference copy) of
#nested arrays. Changes to the deep duplicated array should not
#occur in the original array.
class Array
  def deep_dup
    dup_arr = []
    self.each do |el|
      if el.is_a? Array
        dup_arr << el.deep_dup
      else
        dup_arr << el
      end
    end
    dup_arr
  end

end

#one line implementation of deep dup
class Array
  def deep_dup_short
    self.map { |el| el.is_a?(Array) ? el.deep_dup_short : el }
  end
end


#Recursively calculate the fibonacci sequence up to n values.
#ex fib(2) = > [1, 1]
def fib(n)
  return [] if n <= 0
  return [1] if n == 1
  return [1, 1] if n == 2
  previous_val = fib(n-1) #memoization
  previous_val << previous_val [-1] + previous_val [-2]
end

#Combinations of all size elements of an array
#ex subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
def subsets(arr)
  return [[]] if arr.empty?

  result = []
  subs = subsets(arr[0..-2])
  number = arr[-1]
  subs.each do |el|
    result << el.dup + [number]
  end
  subs + result
end

#Does not work.
def permutation(arr)
  return [] if arr.empty?
  return [arr] if arr.length == 1
  result = []
  keep_in_place = arr[0]
  p keep_in_place
  subs = permutations(arr[0..-2])
  subs.each do |el|

  end
  result << keep_in_place + permutation(arr)
  result
end

#Iteratively solves subsets
def comb(arr)
  result = []
  i = 0
  while i < arr.length
    j = i
    while j < arr.length
      result << arr[i..j]
      j += 1
    end
    i += 1
  end
  result.sort
end


#Binary search on sorted array. Compares target to middle, then splits
#array to lower half and higher half. Recursively runs until either
#target is found or does not exist.
def bsearch(array, target)
  return nil if (target < array[0] || target > array[-1])
  return nil if array.empty?
  if array.length.even?
    mid = (array.length / 2) - 1
  else
    mid = (array.length - 1) / 2
  end
  return mid if array[mid] == target
  if array[mid] > target
    return bsearch(array[0..mid], target)
  else

    right_array = array[mid + 1..-1]
    other_side = array[0..mid].length
    return nil if bsearch(right_array, target).nil?
    return bsearch(right_array, target) + other_side
  end

end

#Merges two sorted arrays into one. In a standard approach you would
#use iteration, NOT recursion to do this.
#ex: merge_recursive([27,38], [3, 43]) => [3, 27, 38, 43]
def merge_recursive(arr1, arr2, merged = [])
  # p "arr1: #{arr1}, arr2: #{arr2}, merged: #{merged}"
  return merged + arr2 if arr1.empty?
  return merged + arr1 if arr2.empty?
  if arr1[0] < arr2[0]
    merged << arr1.shift
  else
    merged << arr2.shift
  end
  return merge_recursive(arr1, arr2, merged)
end

#Splits array in half recusively, then calls merge recursive to put the
#'half' arrays in sorted order. Outputs sorted array.
def mergesort(arr)
  return arr if arr.length <= 1
  left = arr[0...arr.length / 2]
  right = arr[arr.length / 2..-1]
  # p "left: #{left}, right: #{right}"
  sorted_left = mergesort(left)
  sorted_right = mergesort(right)
  merge_recursive(sorted_left, sorted_right)
end

def merge(arr1, arr2)
  merged = []
  while !arr1.empty? && !arr2.empty?
    if arr1[0] < arr2[0]
      merged << arr1.shift
    else
      merged << arr2.shift
    end
  end

end

#Cheater approach: solves greedy change using default array argument
# def greedy_change(target, arr, change = [])
#   return nil if arr.empty?
#   return change if target == 0
#   if target / arr[0] >= 1
#     change << arr[0]
#     target -= arr[0]
#   else
#     arr.shift
#   end
#   greedy_change(target, arr, change)
# end

#Naively determines the coins required to sum to a target value
#ex: greedy_change(24, [10, 7, 1]) => [10, 10, 1, 1, 1, 1]
def greedy_change(target, arr)
  return [] if arr.empty?
  return change if target == 0
  change = []
  while target / arr[0] >= 1
    change << arr[0]
    target -= arr[0]
  end
  arr.shift
  change + greedy_change(target, arr)
end

#Determines minimum number of coins required to sum to target value
#ex make_better_change(24, [10, 7, 1]) => [10, 7, 7]

def make_better_change(target, arr)
  return [] if arr.empty?
  return [target] if arr.include?(target)
  results = []
  arr.each_index do |i|
    change = []
    if arr[i] <= target
      remainder = target - arr[i]
      change << arr[i]
      change += make_better_change(remainder, arr)
      results << change
    end
  end
  array = results.sort_by do |arr|
    arr.length
  end
  array[0]
end

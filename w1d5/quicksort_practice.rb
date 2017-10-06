require 'byebug'
def quicksort(arr, &prc)
  return arr if arr.length < 2
  pivot_idx = 0
  # p prc.call(0, 1)
  left = []
  right = []
  (1...arr.length).to_a.each_index do |index|
    left << arr[index] if (arr[index] < arr[pivot_idx])
  end
  (1...arr.length).to_a.each_index do |index|
    right << arr[index] if (arr[index] >= arr[pivot_idx])
  end

  byebug
  # left = arr[1..-1].select{ |el| (prc.call(el, pivot) < 0) }
  # right = arr[1..-1].select{ |el| prc.call(el, pivot) > 0 }
  quicksort(left) + [arr[pivot_idx]] + quicksort(right)
  #pick partition element
  #move element a position where nothing left is greater and nothing
  #right is less than
  #run quicksort to left and right of new position
  #elements left of partitioned element
end
sorter = Proc.new { |a, b| b <=> a }
p quicksort([99, 5,3,2, 4, 2, 4, 10], &sorter)

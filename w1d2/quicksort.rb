# def sort(arr, pivot = 0)
#
#   return arr if pivot == arr.length
#
#   #put one item into position
#
# end

# def partition(arr, pivot_idx)
#   i = 0
#   j = arr.length - 1
#   while true
#     while arr[i] < arr[pivot_idx]
#       i += 1
#     end
#     while arr[j] > arr[pivot_idx]
#       j -= 1
#     end
#     break if i >= j
#     swap(arr, i, j)
#     p i, j
#   end
#   swap(arr, pivot_idx, j)
#   arr
# end

# def swap(arr, i, j)
#   arr[i], arr[j] = arr[j], arr[i]
# end

#from app academy video
def quicksort(arr)
  return arr if arr.length <= 1
  pivot_arr = [arr.first]
  left_side = arr[1..-1].select { |el| el < arr.first }
  right_side = arr[1..-1].select { |el| el >= arr.first }
  p "left: #{left_side}, piv: #{pivot_arr}, right: #{right_side}"
  quicksort(left_side) + pivot_arr + quicksort(right_side)
end

# arr = ['k', 'r', 'a', 't', 'e', 'l', 'e', 'p', 'u',
      # 'i', 'm', 'q', 'c', 'x', 'o', 's']
arr = [4,2,7,3,6,8]
p quicksort(arr)

# p quicksort(arr)

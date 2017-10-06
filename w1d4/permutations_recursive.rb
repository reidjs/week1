def permute(arr)
  return arr if arr.length == 1
  permutations = []
  arr.each do |el|

  end
  [arr[0]] + permute(arr[1..arr.length])
end
test1 = [1, 2, 3]
# p permute(test1)

def permute_iterative(arr)
  permutations = []
  i = 0
  while i < arr.length - 1
    j = i + 1
    while j < arr.length
      # p arr
      p arr[0...i] + swaparr(arr[i...j], arr[j..arr.length])
      j += 1
    end
    i += 1
  end
  permutations
end

def swaparr(arr1, arr2)
  arr2 + arr1
end

# p sw/aparr([1,2], [3,0])

def swap(arr, i, j)
  arr[i], arr[j] = arr[j], arr[i]
  arr
end

p permute_iterative(test1)

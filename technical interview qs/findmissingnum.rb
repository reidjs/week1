#find the missing number in array
class Array
  #given the min and max range including max num
  def find_missing(min, max)
    (min..max).to_a.each do |n|
      return n if self.index(n).nil?
    end
    nil
  end
end

p [2,3,4,5,6,7].find_missing(1,8)

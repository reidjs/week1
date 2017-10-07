#add my include class to the Array class
class Array
  def my_include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end
end
p [4,2,5,2,1].my_include?(50)

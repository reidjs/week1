#algo to determine if string is all uniq characters
class String
  def is_all_uniq?
    h = {}
    self.chars.each do |c|
      h[c].nil? ? (h[c] = true) : (return false)
    end
    true
  end
end
p "Helo".is_all_uniq?

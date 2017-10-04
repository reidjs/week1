class Card
  attr_accessor :value, :face_up
  def initialize(value)
    @value = value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def turn_over!
    @face_up ? @face_up = false : @face_up = true
  end

  def to_s
    @face_up ? @value : "%"
  end

  def look_at
    @face_up ? @value : nil
  end

  # def ==
  #
  # end

end

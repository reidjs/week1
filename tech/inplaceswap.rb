#swap the values of two variables without a temporary variable
x = ('a'..'c').to_a
y = ('d'..'f').to_a
# p "x: #{x}, y: #{y}"

y.insert(0, x.pop)
x.insert(0, y.pop)
y.insert(0, x.pop)
x.insert(0, y.pop)
y.insert(0, x.pop)
x.insert(0, y.pop)

# p "x: #{sx}, y: #{y}"
p x
p y

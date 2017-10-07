class Tree
  attr_accessor :nodes
  def initialize

  end

end

class Node
  attr_accessor :children, :parent
  def initialize(parent = nil)
    @parent = parent
    @children = []
  end
end
tree = Tree.new

class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent)
    if !@parent.nil?
      @parent.children.each_with_index do |child, i|
        @parent.children.delete_at(i) if child == self
      end
    end
    @parent = parent
    parent.children << self unless parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    self.children.each do |kid|
      if kid == child
        # self.children.delete_at(i)
        child.parent = nil
        return
      end
    end
    raise "Child does not belong here!!!"
  end

  def dfs(target)
    return self if self.value == target
    @children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target
      queue += node.children
    end
    nil
  end

end

if $PROGRAM_NAME == __FILE__
  n1 = PolyTreeNode.new("1")
  n2 = PolyTreeNode.new("2")
  n3 = PolyTreeNode.new("3")
  n5 = PolyTreeNode.new("5")
  n4 = PolyTreeNode.new("4")

# connect n3 to n1
  n3.parent = n2
# connect n3 to n2
  n2.parent = n1
  n4.parent = n2
  n5.parent = n3
  n1.dfs("4")
end

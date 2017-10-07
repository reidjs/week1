class TreeNode
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

class KnightPathFinder
  attr_accessor :move_tree, :visited_positions
  def initialize(pos)
    @move_tree = build_move_tree(pos)
    @visited_positions = []
  end

  def new_move_positions(pos)
    @visited_positions += [pos]
    possible_positions = KnightPathFinder.valid_moves(pos)
    possible_positions.reject! { |spot| @visited_positions.include?(spot) }
    @visited_positions += possible_positions
    possible_positions
  end

  def self.valid_moves(pos)
    row, col = pos
    result = []
    ((row - 2)..(row + 2)).each do |i|
      ((col - 2)..(col + 2)).each do |j|
        if (i - row).abs + (j - col).abs == 3
          result << [i, j] if i.between?(0,8) && j.between?(0, 8)
        end
      end
    end
    result
  end

  def find_path
  end

  def build_move_tree(root)

  end

end

if $PROGRAM_NAME == __FILE__
  p KnightPathFinder.valid_moves([1,2])
end

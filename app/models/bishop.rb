class Bishop < Piece
  
  def valid_move?(x,y)
    return false unless super(x,y)
    return false if path_blocked?(x,y)
    x_diff = x_diff(x)
    y_diff = y_diff(y)
    return true if x_diff == y_diff
    return false
  end
end

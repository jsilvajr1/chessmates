class Queen < Piece

  def valid_move?(x,y)
    return false unless super
    return false unless valid_path?(x,y)
    return false if is_obstructed?(x,y)
    return true
  end

  def valid_path?(x,y)
   (y == self.location_y && x != self.location_x) || (y != self.location_y && x == self.location_x) || (y - self.location_y).abs == (x - self.location_x).abs
  end
end
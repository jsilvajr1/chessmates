class Queen < Piece

  def valid_move?(x,y)
    return false unless super
    return false unless valid_path?(x,y)
    return false if v_obs?(x,y) || h_obs?(x,y) || d_obs?(x,y)
    return true
  end

  # This method defines a valid path for the Queen piece, as instructed in piece.rb
  def valid_path?(x,y)
   (y == self.location_y && x != self.location_x) || (y != self.location_y && x == self.location_x) || (y - self.location_y).abs == (x - self.location_x).abs
  end
end
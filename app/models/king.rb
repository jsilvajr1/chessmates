class King < Piece

  def valid_move?(x,y)
    return false unless super
    current_x = self.location_x
    current_y = self.location_y
    (x - current_x).abs <= 1 && (y - current_y).abs <= 1
  end

end

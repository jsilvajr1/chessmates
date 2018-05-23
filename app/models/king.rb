class King < Piece
  def valid_move?(x,y)
    current_x = self.location_x
    current_y = self.location_y
    [(current_x && current_y+1), (current_x+1 && current_y), (current_x && current_y-1), (current_x-1 && current_y)].include?(x && y)
  end
end

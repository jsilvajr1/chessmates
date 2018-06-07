class Rook < Piece

  def valid_move?(x,y)
    return false unless super(x,y)             
    current_loc_x = self.location_x             
    current_loc_y = self.location_y 
    
    return !v_obs?(x,y) if current_loc_x == x && current_loc_y != y   
    return !h_obs?(x,y)  if current_loc_y == y && current_loc_x != x

    return false                                            
  end
end

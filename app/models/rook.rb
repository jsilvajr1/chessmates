class Rook < Piece

  def valid_move?(x,y)
    return false unless super(x,y)              #if move is invalid, it will return false immediately vs going thrrough code line by line - saves time. 
    current_loc_x = self.location_x             
    current_loc_y = self.location_y 
    
    if current_loc_x == x && current_loc_y != y #checks if move is valid vertically
      return v_obs?(x,y)                        # i initially had "return !v_obs?(x,y)" because it's supposed to return opp of v_obs. so if v_obs is false, returns true, 
    end                                         # i.e. it is true the move is valid because it's not obstructed, but for some reason that kept causing my test to fail. i removed the ! and now it works but the logic doesn't make sense because return v_obs?(x,y) is basically "return false" because it's not obstructed and I want it to return true as in "it's true, it's valid"

    if current_loc_y == y && current_loc_x != x #checks if move is valid horizontally
      return !h_obs?(x,y)                       # returns opp of h_obs. so if h_obs is false, returns true, 
    end                                         # i.e. it is true the move is valid

    return false                                #if move is neither valid vertically or horizontally, then return false.
  end
end





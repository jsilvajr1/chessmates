class Pawn < Piece

  def valid_move?(dest_x, dest_y)
    return false unless super
    # Allow one place movement at a time
    return false unless valid_fwd_move?(dest_x, dest_y)
    return true
  end

  def capture(dest_x, dest_y)
    if self.white
      (dest_y - self.location_y) == 1 && d_obs?(dest_x, dest_y) && (dest_x - self.location_x).abs == 1
    else
      (dest_y - self.location_y) == -1 && d_obs?(dest_x, dest_y) && (dest_x - self.location_x).abs == 1 
    end
  end

  def valid_fwd_move?(dest_x, dest_y)
    if has_moved? && self.white
      (dest_y - self.location_y) == 1 && dest_x == self.location_x
    elsif has_moved? && !self.white
      (dest_y - self.location_y) == -1 && dest_x == self.location_x
    elsif !has_moved? && self.white
      (dest_y - self.location_y) == 2 && dest_x == self.location_x
    else
      (dest_y - self.location_y) == -2 && dest_x == self.location_x
    end
  end

  def has_moved?
    return false if self.location_y == 1 && self.white
    return false if self.location_y == 6 && !self.white
    return true
  end

end

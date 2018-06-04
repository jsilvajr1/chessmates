class Pawn < Piece

  def valid_move?(dest_x, dest_y)
    return false unless super
    # Allow one place movement at a time
    return valid_fwd_move?(dest_x, dest_y)
  end

  def diagonal_move?(dest_x, dest_y)
    return (dest_x - self.location_x).abs == (dest_y - self.location_y).abs && (dest_x - self.location_x).abs == 1
  end

  def valid_fwd_move?(dest_x, dest_y)
    return false unless dest_x == self.location_x || diagonal_move?(dest_x, dest_y) #&& capture_valid?(dest_x, dest_y)
    if has_moved? && self.white
      (dest_y - self.location_y) == 1
    elsif has_moved? && !self.white
      (dest_y - self.location_y) == -1
    elsif !has_moved? && self.white
      [1,2].include?(dest_y - self.location_y)
    else
      [-1,-2].include?(dest_y - self.location_y)
    end

  end

  def capture_valid?(dest_x, dest_y)
    game.occupied?(dest_x, dest_y)
  end

  def has_moved?
    return false if self.location_y == 1 && self.white
    return false if self.location_y == 6 && !self.white
    return true
  end

end

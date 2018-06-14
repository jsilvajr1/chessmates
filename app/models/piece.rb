class Piece < ApplicationRecord

  belongs_to :game

  def valid_move?(x,y)
    return false if self.game.forfeited?
    destination_on_board?(x,y)
  end

  def destination_on_board?(x,y)
    [x,y].all? { |e| (e >= 0) && (e <= 7) }
  end

  def is_obstructed?(x,y)
    v_obs?(x,y) || h_obs?(x,y) || d_obs?(x,y)
  end


  def v_obs?(x,y)
    if (self.location_y < y) && (self.location_x == x)
      count = self.location_y
      while count < (y - 1)
        count = count.next
        if game.pieces.find_by(location_x: x, location_y: count)
          return true
        end
      end
    elsif (self.location_y > y) && (self.location_x == x)
      count = self.location_y
      while count > (y + 1)
        count = count.pred
        if game.pieces.find_by(location_x: x, location_y: count)
          return true
        end
      end
    end
    return false
  end

  def h_obs?(x,y)
    if (self.location_x < x) && (self.location_y == y)
      count = self.location_x
      while count < (x - 1)
        count = count.next
        if game.pieces.find_by(location_x: count, location_y: y)
          return true
        end
      end
    elsif (self.location_x > x) && (self.location_y == y)
      count = self.location_x
      while count > (x + 1)
        count = count.pred
        if game.pieces.find_by(location_x: count, location_y: y)
          return true
        end
      end
    end
    return false
  end

  def d_obs?(x,y)
    if (self.location_x < x) && (self.location_y < y) && (x-self.location_x == y-self.location_y)
      a = self.location_x
      b = self.location_y
      until (a == x) && (b == y)
        a = a.next
        b = b.next
        if game.pieces.find_by(location_x: a, location_y: b)
          return true
        end
      end
    elsif (self.location_x < x) && (self.location_y > y) && (x-self.location_x == self.location_y-y)
      a = self.location_x
      b = self.location_y
      until (a == x) && (b == y)
        a = a.next
        b = b.pred
        if game.pieces.find_by(location_x: a, location_y: b)
          return true
        end
      end
    elsif (self.location_x > x) && (self.location_y < y) && (self.location_x-x == y-self.location_y)
      a = self.location_x
      b = self.location_y
      until (a == x) && (b == y)
        a = a.pred
        b = b.next
        if game.pieces.find_by(location_x: a, location_y: b)
          return true
        end
      end
    elsif (self.location_x > x) && (self.location_y > y) && (self.location_x-x == self.location_y-y)
      a = self.location_x
      b = self.location_y
      until (a == x) && (b == y)
        a = a.pred
        b = b.pred
        if game.pieces.find_by(location_x: a, location_y: b)
          return true
        end
      end
    end
  end


  # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  def move_to!(new_x,new_y)
    dest = game.pieces.find_by(location_x: new_x, location_y: new_y)

    if dest.nil?
      self.update_attributes(location_x: new_x, location_y: new_y, has_moved: true)
    elsif dest.white != self.white # Checking if destination has an enemy_piece. Maybe pull into own method.
      dest.update_attributes(notcaptured: false, location_x: nil, location_y: nil)
      self.update_attributes(location_x: new_x, location_y: new_y, has_moved: true)
    else
      return "ERROR! Cannot move there; occupied by a friendly piece"
    end
  end

  # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


  def can_castle?(rook_x, rook_y)
    rook = game.pieces.find_by(location_x: rook_x, location_y: rook_y)
    # return false if self.has_moved? || rook.has_moved?
    # return false if self.in_check?
    return false if self.h_obs?(rook_x, rook_y)
    return true
  end

  # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  def castle!(rook_x, rook_y)
    rook = game.pieces.find_by(location_x: rook_x, location_y: rook_y)

    if (self.white && rook.white)
      if rook.location_x < self.location_x
        self.update_attributes(location_x: 1, location_y: 0)
        rook.update_attributes(location_x: 2, location_y: 0)
      elsif rook.location_x > self.location_x
        self.update_attributes(location_x: 5, location_y: 0)
        rook.update_attributes(location_x: 4, location_y: 0)
      end
    elsif !(self.white && rook.white)
      if rook.location_x < self.location_x
        self.update_attributes(location_x: 1, location_y: 7)
        rook.update_attributes(location_x: 2, location_y: 7)
      elsif rook.location_x > self.location_x
        self.update_attributes(location_x: 5, location_y: 7)
        rook.update_attributes(location_x: 4, location_y: 7)
      end
    end
  end
end


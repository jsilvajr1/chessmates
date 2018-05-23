class Piece < ApplicationRecord

  belongs_to :game

  def is_obstructed?(x,y)
    v_obs?(x,y) || h_obs?(x,y) || d_obs?(x,y) || invalid(x,y)
  end

  def v_obs?(x,y)
    if (self.location_y < y) && (self.location_x == x)
      count = self.location_y
      until count == y
        count = count.next
        if game.pieces.find_by(location_x: x, location_y: count)
          return true
        end
      end
    elsif (self.location_y > y) && (self.location_x == x)
      count = self.location_y
      until count == y
        count = count.pred
        if game.pieces.find_by(location_x: x, location_y: count)
          return true
        end
      end
    end
  end

  def h_obs?(x,y)
    if (self.location_x < x) && (self.location_y == y)
      count = self.location_x
      until count == x
        count = count.next
        if game.pieces.find_by(location_x: count, location_y: y)
          return true
        end
      end
    elsif (self.location_x > x) && (self.location_y == y)
      count = self.location_x
      until count == x
        count = count.pred
        if game.pieces.find_by(location_x: count, location_y: y)
          return true
        end
      end
    end
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

  def invalid(x,y)
    return "ERROR: Invalid Piece Path"
  end

  def move_to!(new_x,new_y)
    dest = game.pieces.find_by(location_x: new_x, location_y: new_y)

    if dest.nil?
      self.update_attributes(location_x: new_x, location_y: new_y)
    elsif dest.white != self.white
      dest.update_attributes(notcaptured: false, location_x: nil, location_y: nil)
      self.update_attributes(location_x: new_x, location_y: new_y)
    else
      return "ERROR! Cannot move there; occupied by a friendly piece"
    end
  end
end


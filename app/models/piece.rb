class Piece < ApplicationRecord

  belongs_to :game

  def valid_move?(x,y)
    destination_on_board?(x,y)
  end

  def destination_on_board?(x,y)
    [x,y].all? { |e| (e >= 0) && (e <= 7) }
  end

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
end

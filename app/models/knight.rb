class Knight < Piece

  def valid_move?(x,y)
    return false unless super(x,y)
    x_diff = x_diff(x)
    y_diff = y_diff(y)
    if ((x_diff == 2) && (y_diff == 1))
      return true
    end

    if ((y_diff == 2) && (x_diff == 1))
      return true
    end

    return false
  end

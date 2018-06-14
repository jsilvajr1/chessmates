def valid_move?(x, y)
		return false if no_move?(x,y)

		if  ((x - x_coordinate).abs == 2 && (y - y_coordinate).abs == 1) ||
			((x - x_coordinate).abs == 1 && (y - y_coordinate).abs == 2 ) &&
			((x != x_coordinate) && (y != y_coordinate))
			return true
		else
			return false
		end
	end
end

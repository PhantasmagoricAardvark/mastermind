class Board
	@@board = "|1|2|3|4"

	def display
		return @@board
	end

	def add_color
		puts @@board.sub!("1","blue")
	end
end	

board = Board.new
board.add_color
puts board.display
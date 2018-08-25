class Board
	@@board = "1|2|3|4"
	@@boards = []

	def display
		return @@board
	end

	def board_reset
		@@board = "1|2|3|4"
	end

	def boards
		@@boards
	end

	def self.add_color(num, color_num)
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		p @@boards.class
		p @@boards.push("1|2|3|4")
		@@boards.push(@@board.sub!(num.to_s,@colors[color_num])).to_s
	end
end

class Player
	def color(num)
		nums = [1,2,3,4,5,6]
		puts "Input a color number for position #{num}."
		color_num = gets.chomp.to_i
		until nums.include?(color_num)
			puts "Input a valid color number for position #{num}."
			color_num = gets.chomp.to_i

		end
		Board.add_color(num,color_num.to_i)
	end
end
	
class Moderator
	@@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}

	def self.game
		board = Board.new
		player = Player.new
		i = 0
		puts board.display
		while i < 12
			puts
			puts @@colors
			player.color(1)
			player.color(2)
			player.color(3)
			player.color(4)
			board.board_reset
			p
			puts
			puts "Board: " + board.display
		end
	end
end

Moderator.game
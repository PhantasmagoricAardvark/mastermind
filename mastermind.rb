class Board
	@@board = "1|2|3|4"
	@@boards = []

	def display
		save_display
		return @@board
	end

	def boards
		@@boards
	end

	def save_display
		puts "@@board is #{@@board}"
		@@boards.push(@@board)
	end

	def self.add_color(num, color)
		@@board.sub!(num.to_s,color.to_s)
	end
end

class Player
	@@colors = ["red","grn","blu","ylw","blc","wht"]

	def color(num)
		puts "Input a color: #{@@colors}" 
		color = gets.chomp
		Board.add_color(num,color)
	end
end
	
class Moderator
	def self.game
		board = Board.new
		player = Player.new
		i = 0
		puts board.display
		while i < 12
			player.color(1)
			player.color(2)
			player.color(3)
			player.color(4)
			puts board.display
			p "Boards array is #{board.boards}"
		end
	end
end

Moderator.game

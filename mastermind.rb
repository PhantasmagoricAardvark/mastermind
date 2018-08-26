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

	def save
		@@boards.push(@@board)
		puts @@boards
	end

	def self.add_color(num, color_num)
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		@@board.sub!(num.to_s,@colors[color_num])
	end
end

class Player
	def choose_colors
		puts "Input 4 numbers for each position respectively."
		color_nums = gets.chomp.to_s

		until color_nums.length != 4 || string_checker(color_nums)
			puts "4 numbers please."
			color_nums = gets.chomp.to_s
		end
		Board.add_color(1,color_nums[0].to_i)
		Board.add_color(2,color_nums[1].to_i)
		Board.add_color(3,color_nums[2].to_i)
		Board.add_color(4,color_nums[3].to_i)

	end

	def string_checker(string)
		nums = [1,2,3,4,5,6]
		i = 0
		puts string
		while i < 4
			if nums.include?(string[i].to_i) == false
				return false
			end
			i += 1
		end
		true
	end	
end

class Computer
	@@code = "1|2|3|4"
	def make_secret_code
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		@@code = "#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}"
		puts @@code
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
			board.save
			puts
			puts "Board: " + board.display
			board.board_reset
		end
	end
end

player = Player.new
puts player.choose_colors
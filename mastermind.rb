class Board
	@@board = "1|2|3|4"
	@@boards = ["red|red|grn|red"]

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
		puts "boards = #{@@boards}"
	end

	def self.add_color(num, color_num)
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		@@board.sub!(num.to_s,@colors[color_num])
	end

	def self.receive_feedback(secret_code)
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		comparison_code = @@boards[-1]
		i = 0
		comparison_code = "#{@colors.key(comparison_code[0..2])}#{@colors.key(comparison_code[4..6])}#{@colors.key(comparison_code[8..10])}#{@colors.key(comparison_code[12..14])}"
		puts "secret_code is #{secret_code}"
		puts comparison_code
		if secret_code == comparison_code
			return true
		else
			Board.correct_position(comparison_code, secret_code)
		end
	end

	def self.correct_position(code1, secret_code)
		i = 0
		counter = 0
		puts code1
		puts secret_code
		while i < 4
			secret_code[i]
			if code1.include?(secret_code[i])
				puts "secret_code[i] is #{secret_code[i]}"
				code1.to_s.split("").index(secret_code[i],secret_code.index(secret_code[i])) == secret_code.index(secret_code[i])
				if code1.to_s.split("").index(secret_code[i],secret_code.index(secret_code[i])) == secret_code.index(secret_code[i])
					counter += 1
				end
			end
			i += 1
		end
		return puts counter
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

	def feedback
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		@@code = "#{@colors.key(@@code[0..2])}#{@colors.key(@@code[4..6])}#{@colors.key(@@code[8..10])}#{@colors.key(@@code[12..14])}"
		Board.receive_feedback(@@code)
	end
end
	
class Moderator
	@@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}

	def self.game
		board = Board.new
		player = Player.new
		computer = Computer.new
		computer.make_secret_code
		i = 0
		puts board.display
		while i < 12
			puts
			puts @@colors
			player.choose_colors
			board.save
			puts
			puts "Board: " + board.display
			board.board_reset
		end
	end
end

computer = Computer.new
computer.make_secret_code
computer.feedback


class Board
	@@board = "1|2|3|4"
	@@boards = ["red|grn|blu|red"]

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
		code1 = @@boards[-1]
		i = 0
		code1 = "#{@colors.key(code1[0..2])}#{@colors.key(code1[4..6])}#{@colors.key(code1[8..10])}#{@colors.key(code1[12..14])}"
		puts "secret_code is #{secret_code}"
		puts "code1 is #{code1}"
		correct_position = Board.correct_position(code1, secret_code)
		wrong_position = Board.wrong_position(code1, secret_code)
		puts "wrong_position = #{wrong_position}"
		if secret_code == code1
			return p true
		else
			if (correct_position == 1) && (wrong_position == 1)
				puts "There is #{correct_position} color in the correct position, and #{wrong_position} correct color in the wrong position."
			elsif (correct_position > 1 || correct_position == 0) && (wrong_position == 1)
				puts "There are #{correct_position} colors in the correct position, and #{wrong_position} correct color in the wrong position."
			elsif (wrong_position > 1 || wrong_position == 0) && (correct_position == 1)
				puts "There is #{correct_position} color in the correct position, and #{wrong_position} correct colors in the wrong position."
			else
				puts "There are #{correct_position} colors in the correct position, and #{wrong_position} correct colors in the wrong position."
			end
		end
	end

	def self.correct_position(code1, secret_code)
		i = 0
		counter = 0
		while i < 4
			if code1[i] == secret_code[i]
				counter += 1
			end
			i += 1
		end
		return counter
	end

	def self.wrong_position(code1, secret_code)
		counter = 0
		j = 0
		i = 0
		secret_code1 = ""
		secret_code1 = secret_code
		p secret_code
		while i < 4
			if code1[i] == secret_code1[i]
				code1[i] = "0"
				secret_code1[i] = "x"
			end
			i += 1
		end
		i = 0
		while j < 4
			while i < code1.length
				if secret_code1.include?(code1[i]) && (secret_code1.index(code1[i]) != code1.index(code1[i]))
					counter += 1
					secret_code1.sub!(code1[i], "x")
					code1.sub!(code1[i], "0")
					i = 0
				end
				i += 1
			end
			j += 1
		end
		return counter
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
	def make_secret_code
		@code = "1|2|3|4"
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		@code = "#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}"
		@code = "#{@colors.key(@code[0..2])}#{@colors.key(@code[4..6])}#{@colors.key(@code[8..10])}#{@colors.key(@code[12..14])}"
	end

	def feedback
		Board.receive_feedback(@code)
	end

	def code
		p @code
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
		while i < 12
			puts
			puts @@colors
			player.choose_colors
			board.save
			puts computer.feedback
			puts "Board: " + board.display
			board.board_reset
		end
	end
end

Moderator.game

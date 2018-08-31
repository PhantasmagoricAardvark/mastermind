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
		code1 = @@boards[-1]
		i = 0
		code1 = "#{@colors.key(code1[0..2])}#{@colors.key(code1[4..6])}#{@colors.key(code1[8..10])}#{@colors.key(code1[12..14])}"
		puts "secret_code is #{secret_code}"
		puts "code1 is #{code1}"
		if secret_code == code1
			return true
		else
			if (Board.correct_position(code1, secret_code) == 1) && (Board.wrong_position(code1, secret_code) == 1)
				puts "There is #{Board.correct_position(code1, secret_code)} color in the correct position, and #{Board.wrong_position(code1, secret_code)} correct color in the wrong position."
			elsif (Board.correct_position(code1, secret_code) > 1 || Board.correct_position(code1, secret_code) == 0) && (Board.wrong_position(code1, secret_code) == 1)
				puts "Here"
				puts "There are #{Board.correct_position(code1, secret_code)} colors in the correct position, and #{Board.wrong_position(code1, secret_code)} correct color in the wrong position"
			elsif (Board.correct_position(code1, secret_code) > 1 || Board.correct_position(code1, secret_code) == 0) && (Board.wrong_position(code1, secret_code) == 1)
				puts "There is #{Board.correct_position(code1, secret_code)} color in the correct position, and #{Board.wrong_position(code1, secret_code)} correct colors in the wrong position."
			else
				puts "There are #{Board.correct_position(code1, secret_code)} colors in the correct position, and #{Board.wrong_position(code1, secret_code)} correct colors in the wrong position."
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
		puts code1
		puts secret_code
		while i < 4
			if code1[i] == secret_code[i]
				code1[i] = "0"
				secret_code[i] = "x"
			end
			i += 1
		end
		i = 0
		while j < 4
			while i < code1.length
				if secret_code.include?(code1[i]) && (secret_code.index(code1[i]) != code1.index(code1[i]))
					counter += 1
					secret_code.sub!(code1[i], "x")
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
		@@code = "ylw|grn|blc|ylw"
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


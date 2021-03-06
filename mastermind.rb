class Board
	@@board = "1|2|3|4"
	@@boards = []

	def display
		@@board
	end

	def board_reset
		@@board = "1|2|3|4"
	end

	def boards
		@@boards
	end

	def save
		@@boards.push(@@board)
	end

	def self.add_color(position, color_num)
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		@@board.sub!(position.to_s,@colors[color_num.to_i])
	end

	def self.feedback_for_computer(secret_code)
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		code1 = @@boards[-1]
		code1 = "#{@colors.key(code1[0..2])}#{@colors.key(code1[4..6])}#{@colors.key(code1[8..10])}#{@colors.key(code1[12..14])}"
		if code1 == secret_code
			return true
		end
		correct_position = Board.correct_position(code1, secret_code)
		wrong_position = Board.wrong_position(code1, secret_code)
		Computer.feedback_analyzer([correct_position, wrong_position])
	end

	def self.receive_feedback(secret_code)
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		code1 = @@boards[-1]
		i = 0
		code1 = "#{@colors.key(code1[0..2])}#{@colors.key(code1[4..6])}#{@colors.key(code1[8..10])}#{@colors.key(code1[12..14])}"
		if code1 == secret_code
			return true
		end
		correct_position = Board.correct_position(code1, secret_code)
		wrong_position = Board.wrong_position(code1, secret_code)
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
		until string_checker(color_nums)
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
		if string.length != 4 
			return false
		end
		while i < 4
			if nums.include?(string[i].to_i) == false
				return false
			end
			i += 1
		end
		true
	end

	def make_secret_code
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		puts "Choose the secret code!"
		puts @colors
		puts "Input 4 numbers."
		@secret_code = gets.chomp
		until string_checker(@secret_code)
			puts "4 numbers please."
			@secret_code = gets.chomp
		end
	end

	def feedback
		Board.feedback_for_computer(@secret_code.dup)
	end
end

class Computer
	@@i = -1
	@@feedback = []
	@@later_guesses = []
	@@previous_guesses = []
	@@counter = 0


	def make_secret_code
		@code = "1|2|3|4"
		@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}
		@code = "#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}|#{@colors[rand(1..6)]}"
		@code = "#{@colors.key(@code[0..2])}#{@colors.key(@code[4..6])}#{@colors.key(@code[8..10])}#{@colors.key(@code[12..14])}"
	end

	def feedback
		Board.receive_feedback(@code.dup)
	end

	def self.feedback_analyzer(feedback1)
		@@feedback = feedback1
	end

	def color_chooser
		p "@@counter is #{@@counter}"
		if @@counter == 4
			p "@@later_guesses #{@@later_guesses}"
			guess = @@later_guesses.shuffle.join("")
			while @@previous_guesses.include?(guess)
				guess = @@later_guesses.shuffle.join("")
			end
			p guess
			@@previous_guesses.push(guess)
			return guess
		elsif @@feedback[0] != nil
			p "@@feedback[0] is #{@@feedback[0]}"
			@@counter += @@feedback[0]
			@@feedback[0].times {@@later_guesses.push((@initial_guesses[@@i].to_s)[0])}
		end
		if @@counter == 4
			p "@@later_guesses #{@@later_guesses}"
			guess = @@later_guesses.shuffle.join("")
			while @@previous_guesses.include?(guess)
				guess = @@later_guesses.shuffle.join("")
			end
			p guess
			@@previous_guesses.push(guess)
			return guess
		end
		p @@later_guesses
		@initial_guesses = [1111,2222,3333,4444,5555,6666]
		@@i += 1
		@initial_guesses[@@i]
	end

	def choose_colors(guess)
		p "guess is #{guess}"
		Board.add_color(1,guess.to_s[0])
		Board.add_color(2,guess.to_s[1])
		Board.add_color(3,guess.to_s[2])
		Board.add_color(4,guess.to_s[3])
	end

	def code
		@code
	end
end
	
class Moderator
	@@colors = {1 => "red", 2 => "grn", 3 => "blu", 4 => "ylw", 5 => "blc", 6 => "wht"}

	def self.game
		puts "Do you want to choose the secret code? Yes or no?"
		answer = gets.chomp.downcase
		until answer == "yes" || answer == "no"
			puts "tell me again... Yes or no?"
			answer = gets.chomp.downcase
		end
		if answer == "no"
			Moderator.player_guesses
		elsif answer == "yes"
			Moderator.computer_guesses
		end
	end

	def self.player_guesses
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
			if computer.feedback == true
				puts "You guessed the secret code!"
				puts "You win!"
				break
			end	
			puts
			puts "Current board: " + board.display
			board.board_reset
			if i == 11
				puts "You lose!"
				puts "The secret code was #{computer.code}"
				break
			end 
			i += 1
		end
	end

	def self.computer_guesses
		board = Board.new
		player = Player.new
		computer = Computer.new
		player.make_secret_code
		i = 0
		while i < 12
			computer.choose_colors(computer.color_chooser)
			puts 	
			board.save
			player.feedback
			puts "The computer guessed #{board.display}"
			puts
			board.board_reset
			puts board.boards
			if player.feedback == true
				puts
				puts "The computer guessed the secret code!"
				puts "You lose!"
				break
			elsif i == 11
				puts
				puts "You win!"
				puts "The computer did not guess the secret code!"
				break
			end
			i += 1
		end

	end
end

Moderator.game

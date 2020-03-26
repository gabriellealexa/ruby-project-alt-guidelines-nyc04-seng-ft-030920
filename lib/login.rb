class Login 

    attr_accessor :first_name

    def login_menu
        logging_in = User.new

        system("clear")
        puts "Enter your username to begin:"
        username_input = gets.chomp #gets username from user input
        logging_in.find_user_to_login(username_input) #finds user, sets user token, logs in to main menu

    end

end 
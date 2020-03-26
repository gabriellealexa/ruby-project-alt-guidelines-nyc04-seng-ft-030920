require "tty-prompt"

class Register 

    attr_accessor :username_input, :first_name_input, :last_name_input, :age_group_input

    def register_success
        student_grade = GradeLevel.find_by(age_group: @age_group_input)
        student = User.create(grade_level_id: student_grade.id, username: username_input, first_name: first_name_input, last_name: last_name_input, age_group: @age_group_input)
        puts "Success! Registration complete."
        puts "..."
        puts "..."
        system("clear")
        retrieve_me = User.find_by(username: student.username)    
        
        puts "Your username is #{retrieve_me.username}."
            prompt = TTY::Prompt.new
            end_register = prompt.select("Do you want to login, return to the welcome menu, or exit?") do |menu|
                menu.choice 'Login'
                menu.choice 'Back To Welcome Menu'
                menu.choice 'Exit'
            end

            if end_register == 'Login'
                start = Login.new 
                start.login_menu
            elsif end_register == 'Back To Welcome Menu'
                start = CommandLineInterface.new 
                start.greet
            else
                exit 
            end 
        end 


    def register_now
        system("clear")
        puts "Register for a new user account with Canary."
        puts "Desired Username:"
            username_input = gets.chomp
            @username_input = username_input
        puts "First Name:"
            first_name_input = gets.chomp
            @first_name_input = first_name_input 
        puts "Last Name:"
            last_name_input = gets.chomp 
            @last_name_input = last_name_input
        puts "Grade Level:"
            prompt = TTY::Prompt.new
            age_group_input = prompt.select("Choose from the options below.") do |menu|
                menu.choice 'Youth (8-12)'
                menu.choice 'Teen (13-17)'
                menu.choice 'Adult (18+)'
            end 

            if age_group_input == 'Youth (8-12)' #converts grade level text to id number
                @age_group_input = "youth"
            elsif age_group_input == 'Teen (13-17)'
                    @age_group_input = "teen"
            elsif age_group_input == 'Adult (18+)'
                    @age_group_input = "adult"
            end 

    
                

            user_search = User.find_by(username: username_input) #checks if username already exists
            if user_search == nil
                register_success
            else
                prompt = TTY::Prompt.new
                registration_restart = prompt.select("Username already exists! Try again.") do |menu|
                    menu.choice 'Enter different username.'
                    menu.choice 'Return to Welcome Menu.'
                end
             
            
                if registration_restart == 'Enter different username.'
                    puts "..."
                    puts "..."
                    puts "..."
                    system("clear")
                    register_now
                else
                    start = CommandLineInterface.new 
                    start.greet 
                end 

        end 

    end 
end 
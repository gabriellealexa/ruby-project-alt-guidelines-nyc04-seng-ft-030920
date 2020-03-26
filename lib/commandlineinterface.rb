require "tty-prompt"

class CommandLineInterface

    attr_accessor :user_token, :first_name 

    def greet
        prompt = TTY::Prompt.new
        system("clear")
        puts "Welcome to Canary, a sex education app that is shame-free and pleasure-focused."
        welcome = prompt.select("What would you like to do?", %w(Login Register Exit))


        if welcome == "Login"
            start = Login.new 
            start.login_menu
        elsif welcome == "Register"
            start = Register.new
            start.register_now 
        else 
            puts "Goodbye!"
        end 
    end

    def main_menu(user_token)
        binding.pry
        puts "Welcome, #{user_token.first_name}. Lets banish shame and stigma from sex ed!"
        puts "Canary provides age-appropriate web resources on various sexual health, sexuality, and identity topics."
        prompt = TTY::Prompt.new
        main = prompt.select("Where would you like to go?", %w(Learn Preferences Logout))

        if main == "Learn"
            puts "..."
            user_token.choose_lesson
        elsif main == "Preferences"
            puts "..."
            user_token.preferences
        else 
            puts "Taking you back to the welcome menu."
            puts "..."
            puts "..."
            puts "..."
            greet 
        end 
    end 

    
    

    

        
        

end 


class User < ActiveRecord::Base
    belongs_to :grade_level

    attr_accessor :user_token, :user_lessons


    def find_user_to_login(username_input)
        user_search = User.find_by(username: username_input)
        if user_search == nil 
            puts "Username not found!"
            prompt = TTY::Prompt.new
            choice = prompt.select("Try again?", %w(Yes No))
                if choice == "Yes"
                    puts "..."
                    puts "..."
                back_to_start = Login.new 
                back_to_start.login_menu
                else 
                    puts "..."
                    cli = CommandLineInterface.new
                    cli.greet
                end 

        else
            @user_token = user_search #instance of located user
            start = CommandLineInterface.new
            puts "..."
            puts "Verifying username..."
            puts "..."
            puts "Loading user data..."
            puts "..."
            puts "Success, logging you in!"
            puts "..."
            system("clear")
            start.main_menu(@user_token)
        end 
    end 

    def convert_age_symbol
        if self.age_group == "youth"
            @perf = String.new 
            @perf = "Youth (8-12)"
        elsif self.age_group == "teen"
            @perf = String.new 
            @perf = "Teen (13-17)"
        elsif self.age_group == "adult"
            @perf = String.new
            @perf = "Adult (18+)"
        end
    end 


    def choose_lesson #allows user to choose lesson from list
        #system("clear")
        convert_age_symbol 
        puts "Your current age group is #{@perf}!"

        user_lessons = Lesson.all.select do |lesson|
            lesson.age_group == user.age_group
        end 
        
        @user_lessons = user_lessons.map do |names|
                            names.title 
                         end 



        prompt = TTY::Prompt.new 
        learn_ready = prompt.select("Would you like to view your syllabus?") do |menu|
            menu.choice "Yes, lets learn."
            menu.choice "No, lets go back to the main menu."
        end 

            if learn_ready == "Yes, lets learn."
                prompt = TTY::Prompt.new
                choice = prompt.select("Choose a lesson:", @user_lessons)
                get_lesson = Lesson.find_by(title: choice)
                get_lesson.goto_lesson
                puts "..."
                puts "Opening in web browser..."
                puts "..."
                find_user_to_login(self.username)
            else
                find_user_to_login(self.username)
            end 
    end 



    def preferences 
        prompt = TTY::Prompt.new
        choose_pref = prompt.select("Edit your preferences here.") do |menu|
            menu.choice "Change Username"
            menu.choice "Change Age Group"
            menu.choice "Delete Account"
            menu.choice "Exit"
        end

        if choose_pref == "Change Username"
            puts "..."
                change_username(self)
            elsif choose_pref == "Change Age Group"
                change_age_group(self)
            elsif choose_pref == "Delete Account"
                delete_account
            elsif choose_pref == "Exit"
                start = CommandLineInterface.new
                start.main_menu(@user_token)
        end
    end 

    def change_username(user_token)
        system("clear")
        old_name = User.find_by(@user_token)
        puts "Your current username is: #{old_name.username}"
        prompt = TTY::Prompt.new
        confirm_change = prompt.select("Are you sure you want to change it?", %w(Yes No))

            if confirm_change == "Yes"
                puts "What would you like to change it to?"
                new_name = gets.chomp
                puts "Type new username again to confirm."
                new_name_redo = gets.chomp

                user_search = User.find_by(username: new_name) 
                if user_search == nil && new_name == new_name_redo
                    self.username = new_name
                    self.save

                    prompt = TTY::Prompt.new
                    finalize = prompt.select("Success! Your username is now: #{self.username}.", %w(Back))
                
                    if finalize == "Back"
                        system("clear")
                        start = CommandLineInterface.new
                        start.main_menu(self)
                    else
                        system("clear")
                        start = CommandLineInterface.new
                        start.main_menu(self)
                    end 
                else
                    prompt = TTY::Prompt.new
                    change_username_redo = prompt.select("Error! Either username already exists or username inputs didn't match.") do |menu|
                        menu.choice 'Enter different username.'
                        menu.choice 'Return to Welcome Menu.'
                        end
                    
                    if change_username_redo == "Enter different username."
                        change_username(self) 
                    else 
                        start = CommandLineInterface.new
                        start.main_menu(@user_token)
                    end 
    
                end 
            end 
    end




        def change_age_group(user_token)
            system("clear")
            current_age = User.find_by(@user_token)
            convert_age_symbol 

            puts "Your current age group is: #{@perf}"
            prompt = TTY::Prompt.new
            confirm_change = prompt.select("Are you sure you want to change it?", %w(Yes No))

            if confirm_change == "Yes"
                    prompt = TTY::Prompt.new
                    age_group_input = prompt.select("Choose from the options below.") do |menu|
                    menu.choice 'Youth (8-12)'
                    menu.choice 'Teen (13-17)'
                    menu.choice 'Adult (18+)'
                    end 

                if age_group_input == 'Youth (8-12)' #converts grade level text to id number
                    self.age_group = "youth"
                    self.save
                elsif age_group_input == 'Teen (13-17)'
                    self.age_group = "teen"
                    self.save
                elsif age_group_input == 'Adult (18+)'
                    self.age_group = "adult"
                    self.save
                end 

                    prompt = TTY::Prompt.new
                    finalize = prompt.select("Success! Your age group is now: #{age_group_input}.", %w(Back))
                
                    if finalize == "Back"
                        system("clear")
                        start = CommandLineInterface.new
                        start.main_menu(self)
                    else
                        system("clear")
                        start = CommandLineInterface.new
                        start.main_menu(self)
                    end 

            
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

        def delete_account
            puts "Deleting your account is permanent. If you change your mind, you will have to register again."
            prompt = TTY::Prompt.new
            delete_confirm = prompt.select("Are you sure you want to continue?") do |menu|
                menu.choice "Yes, delete my account."
                menu.choice "No, take me back to preferences."
            end 

            if delete_confirm == "Yes, delete my account."
                confirm_confirm = prompt.select("Confirm one more time.", %w(Delete Cancel))

                if confirm_confirm == "Delete"
                    puts "..."
                    puts "..."
                    puts "Deleting account ..."
                    puts "..."
                    puts "..."
                    puts "Account deleted. We're sorry to see you go!"
                    self.destroy
                    start = CommandLineInterface.new 
                    start.greet 
                else 
                    system("clear")
                    preferences 
                end 
            else
                system("clear")
                preferences
            end 
        end 







    end

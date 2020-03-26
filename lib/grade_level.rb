class GradeLevel < ActiveRecord::Base
    has_many :lessons
    has_many :users

    attr_accessor :lessons_by_grade

    def youth_lessons_list
        Lesson.all.select do |lesson|
            lesson.age_group == "youth"
        end 
    end 

    def teen_lessons_list
        Lesson.all.select do |lesson|
            lesson.age_group == "teen"
        end 
    end 

    def adult_lessons_list
        Lesson.all.select do |lesson|
            lesson.age_group == "adult"
        end 
    end 

    def lessons_by_grade
        @lessons_by_grade = []

        if self.age_group = "youth"
            @lessons_by_grade << youth_lessons_list
        elsif self.age_group = "teen"
            @lessons_by_grade << teen_lessons_list
        elsif self.age_group = "adult"
            @lessons_by_grade << adult_lessons_list
        end
        @lessons_by_grade 
    end




end
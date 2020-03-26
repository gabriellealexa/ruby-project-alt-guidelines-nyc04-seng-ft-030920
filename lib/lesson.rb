require 'launchy'

class Lesson < ActiveRecord::Base
    belongs_to :grade_level

    attr_accessor :user_token, :grade_level_id, :load_user_lessons


    def goto_lesson
        open = self.link
        Launchy.open(open) 
    end



end
class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.integer :grade_level_id
      t.string :title
      t.string :source
      t.text :description
      t.string :link
      t.string :age_group
    end

    Lesson.reset_column_information


  end
end

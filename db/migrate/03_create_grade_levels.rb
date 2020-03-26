class CreateGradeLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :grade_levels do |t|
      t.string :age_group
    end

    GradeLevel.reset_column_information

  end
end

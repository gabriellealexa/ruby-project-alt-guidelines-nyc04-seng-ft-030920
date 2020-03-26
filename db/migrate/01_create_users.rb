class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :grade_level_id
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :age_group
    end

    User.reset_column_information

  end
end

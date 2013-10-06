class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :title
      t.string :url_key

      t.timestamps
    end

    create_table :departments_users do |t|
        t.integer :department_id
        t.integer :user_id
    end
  end
end

class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title, :null => false
      t.text :body, :null => false
      t.string :url_key, :null => false
      t.string :status, :null => false
      t.string :reporter_email, :null => false
      t.string :reporter_name, :null => false

      t.timestamps
    end

    create_table :tickets_users do |t|
        t.integer :user_id
        t.integer :ticket_id
    end
  end
end

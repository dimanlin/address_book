class AddColumnEmailsAndPhoneNumbers < ActiveRecord::Migration
  def change
    add_column :users, :emails, :text
    add_column :users, :phone_numbers, :text
  end
end

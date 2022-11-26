class AddNumberToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :number, :integer
  end
end

class AddMessagesToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :messages, :text, array: true, default: []
  end
end

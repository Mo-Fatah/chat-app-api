class ChatsController < ApplicationController
  def index 
    application = Application.find{|app| app.token == params[:application_id]}
    chats = Chat.select{|chat| chat.application_id == application.id }
    render json: chats
  end 

  def create
    application = Application.find{|app| app.token == params[:application_id]}
    puts application
    chat = Chat.new(name: params[:name], application: application, number: application.chats_count + 1)
    if chat.save
      application.chats_count = application.chats_count + 1
      application.save
      render json: chat
    else 
      render json: chat.errors, status: unprocessable_entity
    end 
  end

  def show
    puts params[:id]
    application = Application.find{|app| app.token == params[:application_id]}
    chat = Chat.find{|chat| chat.id == params[:id].to_i && chat.application_id == application.id}
    render json: chat
  end
end

class ChatsController < ApplicationController
  def index 
    application = Application.find{|app| app.token == params[:application_id]}
    chats = Chat.select{|chat| chat.application_id == application.id }
    render json: chats, only: [:name, :number]
  end 

  def create
    application = Application.find{|app| app.token == params[:application_id]}
    puts application
    chat = Chat.new(
      name: params[:name],
      application: application, 
      number: application.chats_count + 1,
      messages_count: 0,
      messages: []
    )

    if chat.save
      application.chats_count = application.chats_count + 1
      application.save

      render json: {
        number: chat.number,
        name: chat.name,
        application_id: params[:application_id],
        messages_count: chat.messages_count,
        messages: chat.messages
      }

    else 
      render json: chat.errors, status: unprocessable_entity
    end 
  end

  # TODO: should be show messages 
  def show
    puts params[:id]
    application = Application.find{|app| app.token == params[:application_id]}
    chat = Chat.find{|chat| chat.number == params[:id].to_i && chat.application_id == application.id}
    render json: chat.messages
  end

  def post_message
    # message format in json
    # {"username": "{username}", "content": "{message_content}", "number": "{message_number}"}
    if params[:content] == nil || params[:username] == nil 
      render json: "ERROR: Username and Content must be provided\n", status: :unprocessable_entity
    else
      application = Application.find{|app| app.token == params[:application_id]}
      chat = Chat.find{|chat| chat.application_id == application.id && params[:id].to_i == chat.number}
      message = {
        username: params[:username],
        content: params[:content],
        number: chat.messages_count + 1
      }
      chat.messages << message
      chat.messages_count += 1
      chat.save
      render json: chat
    end
  end

  def search_messages
    render json: params
  end
end

class ApplicationsController < ApplicationController
  def index
    render json: Application.all
  end

  def show
    token = params[:id]
    app = Application.find{|app| app.token == token}
    render json: app
  end

  def create
    uuid = SecureRandom.hex(4)
    application = Application.new(name: application_params[:name], token: uuid, chats_count: 0)
    if application.save
      render json: "Success", status: :created
    else 
      render json: application.errors, status: :unprocessable_entity
    end
  end

  private 

  def application_params
    params.require(:application).permit(:name)
  end
end

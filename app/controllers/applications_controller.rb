class ApplicationsController < ApplicationController
  def index
    render json: Application.all, only: [:token, :name]
  end

  def show
    token = params[:id]
    app = Application.find{|app| app.token == token}
    render json: {
      name: app.name,
      token: app.token
    }

  end

  def create
    uuid = SecureRandom.hex(4)
    application = Application.new(name: application_params[:name], token: uuid, chats_count: 0)
    if application.save
      render json: application, only: [:token, :name]
    else 
      render json: {
        name: app.name,
        token: app.token
      }
    end
  end

  private 

  def application_params
    params.require(:application).permit(:name)
  end
end

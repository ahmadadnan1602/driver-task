
class Api::V1::DriversController < ApplicationController
	skip_before_action :verify_authenticity_token 
	respond_to :json

  swagger_controller :drivers, 'Drivers'

  swagger_api :index do
    summary 'Returns all drivers'
    notes 'Notes...'
  end

  def index
    @drivers = Driver.all
    message = @drivers.present? ? 'Driver List' : 'No such driver is present in the list'
    data = {
      data: @drivers,
      message:
    }
    render json: data, status: :ok
  end

  def add_user
    user = User.new(email: params[:email], password: params[:password])
    if user.save
      data = {data: user, message: "User got created..."}
    else
      data = {message: "Upps,user creation got failed.."}
    end
    render json: data, status: :ok
  end
  def user_lists
    @users = User.all
    message = @users.present? ? 'Users List' : 'No such user is present'
    data = { data: @users, message: "Users list"}
    render json: data, status: :ok
  end

  def new_driver
  	driver = Driver.new(name:params[:name], address:params[:address], licence_number:params[:licence_number],d_o_b: params[:d_o_b],user_id: params[:user_id])
    if driver.save
      data = {data: driver, message: "Driver created"}
    else
      data = {message: "Driver not created"}
    end
    render json: data, status: :ok
  end

  def add_new_cards
    card = CardDetail.new(card_no:params[:card_no], expiry_month: params[:expiry_month], expiry_year: params[:expiry_year],  is_active: params[:is_active], is_default: params[:is_default] ,driver_id: params[:driver_id])
    if card.save
      data = {data: card, message: "Card created"}
    else
      data = {message: "Card creation failed"}
    end
    render json: data, status: :ok
  end

  def card_details
    @driver = Driver.find_by(params[:driver_id])
    @card_details = @driver.card_details
    render json: @card_details, status: :ok
  end
end

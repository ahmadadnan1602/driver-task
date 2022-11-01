class Api::V1::TransactionsController < ApplicationController
	skip_before_action :verify_authenticity_token 
	respond_to :json
	swagger_controller :transactions, 'Transactions'

  def add_fuel
    driver = Driver.find(params[:driver_id])
    @fuel = driver.fuels.new(amount: params[:amount], description: params[:description], transaction_type: params[:transaction_type])
    if @fuel.save
    	transaction = @fuel.transaction_histories.create(amount: @fuel.amount, transaction_type: @fuel.transaction_type, driver_id: driver.id )
    	transaction.update(is_settle:true) if transaction.transaction_type == "card_type"
    	WalletHistoryService.new(driver_id: params[:driver_id]).add_wallet_history   	
    end
    render json: @fuel, status: :ok
  end

  def wallet_history
  	WalletHistoryService.new(driver_id: params[:driver_id]).add_wallet_history
  	driver = Driver.find(params[:driver_id])
  	@wallet_history = driver.wallet_histories.where(driver_id: driver.id).first
    data = { data:@wallet_history, message: 'Wallet_history successfully updated' } if @wallet_history.present?
    render json: data , status: :ok
  end

  def overall_paylater_amount
  	wallet = Wallet.find_by_wallet_type(1)
  	data = { Amount: wallet.total_amount, message: "Overall Paylater Amount of Driver"}
  	render json: data , status: :ok
  end

  def transaction_histories
  	transaction = TransactionHistory.where(driver_id: params[:driver_id])
  	data = { transactions: transaction, message: "Driver all Transaction Histories"}
  	render json: data , status: :ok
  end

  def settle_transaction
  	driver = Driver.find(params[:driver_id])
  	transaction_history = driver.transaction_histories.find_by_id(params[:transaction][:transaction_history_id])
  	if transaction_history.update(is_settle:true)
  		WalletHistoryService.new(driver_id: params[:driver_id]).add_wallet_history
  		data = { transaction_history: transaction_history, message: "Transaction successfully settle"}
  	else
  		data = { message: "Transaction is not settle"}
  	end
  	render json: data , status: :ok
  end
end

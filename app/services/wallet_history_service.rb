class WalletHistoryService
  def initialize(driver_id)
    @driver_id = driver_id
  end

  def add_wallet_history
    driver = Driver.find(@driver_id[:driver_id])
    card_detail = driver.card_details.default_true.first
    transaction_histories = driver.transaction_histories.non_settled_transactions
    if transaction_histories.present? && card_detail.present?
      transaction_histories_ids = transaction_histories.ids.join(',')
      total_amount = transaction_histories.map(&:amount).sum
      wallet = Wallet.find_by_wallet_type(1)
      wallet = Wallet.create(total_amount: total_amount, wallet_type: 1) if wallet.blank?
      wallet_history = driver.wallet_histories.where(driver_id: driver.id).update(total_amount: total_amount, transaction_histories_ids:transaction_histories_ids).first
      wallet_history = driver.wallet_histories.create(total_amount:total_amount, transaction_histories_ids: transaction_histories_ids, card_detail_id: card_detail.id, wallet_id: wallet.id) if wallet_history.blank?
      wallet = Wallet.find_by_wallet_type(1)
      wallet_total_amount = wallet.wallet_histories.map(&:total_amount).sum
      wallet.update(total_amount: wallet_total_amount)
    elsif transaction_histories.blank?
      wallet_history = driver.wallet_histories.where(driver_id: driver.id).update(total_amount: 0, transaction_histories_ids: "0").first
      total_amount = TransactionHistory.non_settled_transactions.map(&:amount).sum
      if total_amount.present?
        wallet = Wallet.find_by_wallet_type(1)
        wallet_total_amount = wallet.wallet_histories.map(&:total_amount).sum
        wallet.update(total_amount: wallet_total_amount)
      else
        wallet = Wallet.find_by_wallet_type(1)
        wallet.update(total_amount: 0)
      end
    else
    end
  end
end
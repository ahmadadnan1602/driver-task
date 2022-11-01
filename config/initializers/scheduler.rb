require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '0 1 * * *' do
  Driver.find_each do |driver|
    WalletHistoryService.new(driver_id: driver.id).add_wallet_history
  end
end
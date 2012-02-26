class RenameFuturesTableToQuotesTable < ActiveRecord::Migration
  def up
    rename_table :futures, :quotes
  end

  def down
    rename_table :quotes, :futures
  end
end

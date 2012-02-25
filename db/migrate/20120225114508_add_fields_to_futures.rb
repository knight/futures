class AddFieldsToFutures < ActiveRecord::Migration
  def change
    add_column :futures, :ticker, :string

    add_column :futures, :dyyyymmdd, :int

    add_column :futures, :open, :int

    add_column :futures, :high, :int

    add_column :futures, :low, :int

    add_column :futures, :close, :int

    add_column :futures, :vol, :int

    add_column :futures, :openint, :int

  end
end

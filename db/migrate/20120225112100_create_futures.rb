class CreateFutures < ActiveRecord::Migration
  def change
    create_table :futures do |t|
      t.timestamps
    end
  end
end

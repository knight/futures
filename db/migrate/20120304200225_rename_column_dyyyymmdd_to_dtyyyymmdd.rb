class RenameColumnDyyyymmddToDtyyyymmdd < ActiveRecord::Migration
  def up
    rename_column :quotes, :dyyyymmdd, :dtyyyymmdd
  end

  def down
    rename_column :quotes, :dtyyyymmdd, :dyyyymmdd
  end
end

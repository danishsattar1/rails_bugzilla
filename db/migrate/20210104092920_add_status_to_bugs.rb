class AddStatusToBugs < ActiveRecord::Migration[6.0]
  def change
    add_column :bugs, :status, :string, default: "new"
  end
end

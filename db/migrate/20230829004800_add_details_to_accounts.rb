class AddDetailsToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :address, :text 
    add_column :accounts, :var_rate, :float
    add_column :accounts, :tax_payer_id, :string
    add_column :accounts, :default_currency, :string
  end
end

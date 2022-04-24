class AddUuidToUsers < ActiveRecord::Migration[7.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()'
  end
end

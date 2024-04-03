class CreatePowerphoneConfigurations < ActiveRecord::Migration[7.1]
  def change
    create_table :powerphone_configurations do |t|
      t.string :sip_domain
      t.string :wss_server
      t.string :wss_port
      t.string :wss_path

      t.timestamps
    end
  end
end

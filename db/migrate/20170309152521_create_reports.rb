class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.references  :user,      foreign_key: true
      t.string      :payload
      t.integer     :status,    index: true,      default: 0
      t.timestamps
    end
  end
end

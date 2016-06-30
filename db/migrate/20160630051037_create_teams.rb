class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :ancestry

      t.timestamps null: false, include_deleted_at: true
      t.userstamps index: true, include_deleter_id: true
    end
  end
end

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, primary_key: "uid", id: :string, comment: "ユーザーID", default: nil, force: true do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end

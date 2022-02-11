class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid, null: false, limit: 30, comment: "ユーザー表示ID"
      t.string :name, null: false, limit: 20, comment: "名前"
      t.string :email, null: false, limit: 255, comment: "メールアドレス"

      t.timestamps
    end
  end
end

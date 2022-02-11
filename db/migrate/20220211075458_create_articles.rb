class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, index: true, foreign_key: true, comment: "ユーザーID"
      t.string :title, null: false, limit: 30, comment: "記事タイトル"
      t.text :text, null: false, comment: "記事内容"

      t.timestamps
    end
  end
end

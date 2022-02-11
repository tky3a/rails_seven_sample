class CreateTagArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_articles do |t|
      t.references :tag, null: false, index: true, foreign_key: true, comment: "タグID"
      t.references :article, null: false, index: true, foreign_key: true, comment: "記事ID"

      t.timestamps
    end
  end
end

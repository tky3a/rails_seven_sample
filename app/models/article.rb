class Article < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :tag_articles # 中間テーブルの設定
  has_many :tag_articles # 多対多の中間テーブルを参照
end

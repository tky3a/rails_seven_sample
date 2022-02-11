class Tag < ApplicationRecord
    # 順番が重要
    has_many :tag_articles # 多対多の中間テーブルを参照
    has_many :articles, through: :tag_articles # 中間テーブルの設定
end

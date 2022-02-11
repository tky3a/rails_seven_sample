class TagArticle < ApplicationRecord
  # 順番が重要
  belongs_to :article
  belongs_to :tag
end

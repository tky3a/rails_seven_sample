class StaticPagesController < ApplicationController
  def home
    # includesで関連付けられているモデルをあらかじめ取得(パフォーマンスチューニング)
    @articles = Article.includes(:tags)
  end

  def help
  end
end

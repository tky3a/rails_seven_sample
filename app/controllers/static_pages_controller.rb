class StaticPagesController < ApplicationController
  def home
    puts "--------------start-----------------"

    tag_articles = TagArticle.where(article_id: 1)
    tag_ids = tag_articles.pluck(:tag_id)
    tags = Tag.where(id: tag_ids)
    print "取得したタグ： #{tags.pluck(:name)}"
    puts "--------------end-----------------"
  end

  def help
  end
end

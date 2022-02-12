class ArticlesController < ApplicationController
  def index
      # includesで関連付けられているモデルをあらかじめ取得(パフォーマンスチューニング)
      # left outer join
      @articles = Article.includes(:tags)
  end

  def new
    # 作成したArticleTagクラスのインスタンスを作成(FormObjectのクラスを参照)
    @article = ArticleTag.new
  end

  def create
    # TODO: ユーザーはセッションから取得できるように修正する
    user = User.find(1)

    # 作成したArticleTagクラスのインスタンスを作成
    @article = ArticleTag.new(article_tag_params)
    # ArticleTagクラスで作成したsaveメソッドを実行
    @article.save(user)

    redirect_to root_path
  end


  private
  # articleとtabを合わせたストロングパラメータ
  def article_tag_params 
    params.require(:article_tag).permit(:name, :title, :text)
  end
end

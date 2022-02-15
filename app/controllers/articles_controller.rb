class ArticlesController < ApplicationController
  def index
    # includesで関連付けられているモデルをあらかじめ取得(パフォーマンスチューニング)
    # left outer join
    @articles = Article.includes(:tags).order(updated_at: :desc)
  end

  def show
    uid = params[:uid]
    user = User.find_by(uid: uid)
    @article = user.articles.find(params[:id])
  end

  def new
    # 作成したArticleTagクラスのインスタンスを作成(FormObjectのクラスを参照)
    @article = ArticleTag.new
  end

  def create
    # TODO: ユーザーはセッションから取得できるように修正する
    user = User.find(1)
    # 作成したArticleTagクラスのインスタンスを作成
    @article = ArticleTag.new(params: article_tag_params)
    # ArticleTagクラスで作成したsaveメソッドを実行
    saveParams = @article.save(user)
    if saveParams
      redirect_to root_path, notice: "記事を作成しました。", turbo: false
    else
      p "保存失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    uid = params[:uid]
    article_id = params[:id]
    current_article = Article.find(article_id)
    # インスタンスを直接取得するだけでは初期値の表示ができなかった為 current_article で所得している
    @article = ArticleTag.new(article: current_article).current_article
  end

  def update
    # TODO: ユーザーはセッションから取得できるように修正する
    user = User.find_by(uid: params[:uid])
    current_article = Article.includes(:tags).find(params[:id])

    # 作成したArticleTagクラスのインスタンスを作成
    @article = ArticleTag.new(params: params[:article].blank? ? article_tag_params : article_params, article: current_article)
    saveParams = @article.save(user)
    # ArticleTagクラスで作成したsaveメソッドを実行
    saveParams = @article.save(user)
    if saveParams
      redirect_to article_path(id: params[:id], uid: params[:uid]), notice: "記事を更新しました。", turbo: false
    else
      p "更新失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  # articleとtabを合わせたストロングパラメータ
  def article_tag_params
    params.require(:article_tag).permit(:name, :title, :text)
  end

  # 更新画面用ストロングパラメータ
  # TODO: 変更画面からリクエストした場合にarticle_tagではなく、articleとなってしまうため暫定対応
  def article_params
    params.require(:article).permit(:name, :title, :text)
  end
end

class ArticlesController < ApplicationController
  def index
    # includesで関連付けられているモデルをあらかじめ取得(パフォーマンスチューニング)
    # left join
    @articles = Article.includes(:tags)
      .page(params[:page])
      .per(10).order(updated_at: :desc)

    #kaminariのカスタムテーマ
    # https://webdesignfacts.net/entry/css-pagenations/#gsc.tab=0
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
    # トランザクション処理
    begin
      ActiveRecord::Base.transaction {
        # ArticleTagクラスで作成したsaveメソッドを実行
        saveParams = @article.save(user)
        if saveParams
          redirect_to root_path, notice: "記事を作成しました。", turbo: false
        else
          p "バリデーションエラーです"
          render :new, status: :unprocessable_entity
        end
      }
    rescue => e
      # https://qiita.com/yujiG/items/3e34e2e0e7b4120b0584
      p "例外エラー: 保存に失敗しました"
      p e
      @article.errors.add(:exseption, "例外エラーです")
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

    # トランザクション処理
    begin
      ActiveRecord::Base.transaction {
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
      }
    rescue => e
      # https://qiita.com/yujiG/items/3e34e2e0e7b4120b0584
      p "例外エラー: 保存に失敗しました"
      p e
      @article.errors.add(:exseption, "例外エラーです")
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    # 検索ワードを保持
    @search_word = params[:keyword]
    if params[:keyword].blank?
      @articles = @articles = Article.includes(:tags).order(updated_at: :desc)
    else
      # 複数条件での検索(articleに紐づいたtag名と、articleのタイトルと内容に検索ワードが存在しているものを検索)
      @articles = Article.left_outer_joins(:tags)
        .where(["tags.name LIKE(?) OR title LIKE(?) OR text LIKE(?)", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
        .order(updated_at: :desc)
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

# ArticleとTabを１つのフォームで同時登録するためのフォームオブジェクトクラス
class ArticleTag
  include ActiveModel::Model
  # 登録に必要なパラメータを設定（articleとtab）
  attr_accessor :user_id, :title, :text, :name

  # バリデーション
  # https://qiita.com/Tiima/items/b14c73df98d0465cbb52
  with_options presence: true do
    validates :title
    validates :text
    validates :name
  end

  # 初期インスタンス作成
  def initialize(article: Article.new, params: {})
    @article = article
    super(params)
  end

  # ここにモデル2つを介して値を保存する記述を施す
  def save(user)
    # バリデーションエラーの場合はfalseをreturn
    return false if invalid?

    # トランザクション処理
    ActiveRecord::Base.transaction do
      if @article.persisted?
        # 更新処理
        @article.title = title
        @article.text = text
        tagNameArray = name.split(" ")
        addTags(tagNameArray, @article)
        @article.save!
        true
      else
        # 新規登録処理
        tagNameArray = name.split(" ")
        # Articleの登録インスタンス作成
        article = user.articles.build(title: title, text: text)
        #Tagの登録インスタンス作成
        tagNameArray.each do |tagName|
          if Tag.exists?(name: tagName)
            tag = Tag.find_by(name: tagName)
            article.tags << tag
          else
            article.tags.build(name: tagName)
          end
        end
        article.save!
        true
      end
    end
    # 保存できなかった場合の例外処理
  rescue ActiveRecord::RecordInvalid
    return false
  end

  # タグつけ処理
  def addTags(tagNameArray, article)
    # 現在紐づいてる中間テーブルがあれば全て削除
    # 失敗時にロールバックするためトランザクションで１件ずつ
    ActiveRecord::Base.transaction do
      article.tag_articles.each do |tag_article|
        tag_article.destroy!
      end
    end

    # 紐付け処理
    tagNameArray.each do |tagName|
      # DBに存在している名前ならそのまま追加、新規なら新規追加
      if Tag.exists?(name: tagName)
        tag = Tag.find_by(name: tagName)
        article.tags << tag
      else
        article.tags.build(name: tagName)
      end
    end
  end

  def current_article()
    return @article
  end
end

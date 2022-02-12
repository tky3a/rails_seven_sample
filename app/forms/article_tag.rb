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

  # ここにモデル2つを介して値を保存する記述を施す
  def save(user)
    # バリデーションエラーの場合はfalseをreturn
    return false if invalid?

    # トランザクション処理
    ActiveRecord::Base.transaction do
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
    # 保存できなかった場合の例外処理
    rescue ActiveRecord::RecordInvalid
      return false
  end
end

# ArticleとTabを１つのフォームで同時登録するためのクラス
class ArticleTag
    include ActiveModel::Model
    # 登録に必要なパラメータを設定（articleとtab）
    attr_accessor :user_id, :title, :text, :name

    # todo: バリデーション
    # https://qiita.com/Tiima/items/b14c73df98d0465cbb52

    # ここにモデル2つを介して値を保存する記述を施す
    def save(user)
        tagNameArray = name.split(' ') 
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
    end
end
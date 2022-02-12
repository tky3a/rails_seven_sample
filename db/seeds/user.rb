# ユーザー作成
5.times do |n|
    User.create!(uid: Faker::Lorem.unique.characters(number: 15), name: Gimei.kanji, email: Faker::Internet.unique.email)
end

# ランダムで３人のユーザーを取得
users = User.order("RAND()").limit(3)

# タブを作成
Tag.create!(name: "Rails")
Tag.create!(name: "html")
Tag.create!(name: "JavaScript")
  
tags = Tag.all

# ユーザーに紐づいた記事作成
users.each do |user|
    # articleのインスタンス作成
    user.articles.build(title: Faker::Movie.title, text: Faker::Lorem.sentence)
    # tagのインスタンスをランダムで取得
    tag = Tag.order("RAND()").first
    # tagsに代入
    user.articles[0].tags << tag
    # ユーザー、記事、タグ、記事とタグの中間テーブルを同時に保存
    user.save!
end
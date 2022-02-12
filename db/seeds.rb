# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
# requireせずとも各seedファイルが読み込まれる様に追加
Dir[File.expand_path('./db/seeds' << '/*.rb')].each do |file|
    require file
end
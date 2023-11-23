# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  Admin.create!(email: 'o@shisha', password: 'oshisha')
   
  10.times do |num|
  User.create!(
    name: "シーシャ#{num + 1}本目",
    email: "a#{num + 1}@a",
    password: "aaaaaa#{num + 1}",
    password_confirmation: "aaaaaa#{num + 1}",
    profile: "シーシャは一日#{num + 1}本吸う",
    shisha_resistance: 3
    )
  end
  
  Post.create!(
    [
      {
        user_id: 1,
        title: "オランジュ",
        body: "吸いやすくて美味しいです。",
        flavor_genre: 1,
        player: 0,
        location: "表参道",
        hms_genre: 0,
        top_genre: 0,
        duration: 120,
        price: 3000,
        flavor_capacity: 12,
        flavor_maker: "アルファーヘル",
        smoking_level: 1,
        smoking_taste_level: 1,
        bottle_option: false,
        nicotine: true,
        star: 4
      },
       {
        user_id: 2,
        title: "パティサ",
        body: "濃い！美味しいです。",
        flavor_genre: 2,
        player: 0,
        location: "春日部",
        hms_genre: 0,
        top_genre: 0,
        duration: 180,
        price: 3500,
        flavor_capacity: 18,
        flavor_maker: "自家製",
        smoking_level: 1,
        smoking_taste_level: 1,
        bottle_option: false,
        nicotine: true,
        star: 5
      },
       {
        user_id: 3,
        title: "キメト",
        body: "ここが日本一です。",
        flavor_genre: 3,
        player: 0,
        location: "浅草",
        hms_genre: 1,
        top_genre: 0,
        duration: 120,
        price: 2500,
        flavor_capacity: 12,
        flavor_maker: "自家製",
        smoking_level: 1,
        smoking_taste_level: 1,
        bottle_option: false,
        nicotine: true,
        star: 5
      },
       {
        user_id: 1,
        title: "表参道オランジュ",
        body: "初心者にもおすすめです。",
        flavor_genre: 3,
        player: 0,
        location: "表参道",
        hms_genre: 0,
        top_genre: 0,
        duration: 120,
        price: 3000,
        flavor_capacity: 12,
        flavor_maker: "アルファーヘル",
        smoking_level: 1,
        smoking_taste_level: 1,
        bottle_option: false,
        nicotine: true,
        star: 5
      },
       {
        user_id: 4,
        title: "クリームソーダ",
        body: "レシピは後日記載。改善の余地あり",
        flavor_genre: 4,
        player: 1,
        location: "表参道",
        hms_genre: 0,
        top_genre: 0,
        duration: 100,
        price: 500,
        flavor_capacity: 25,
        flavor_maker: "ドザジ",
        smoking_level: 0,
        smoking_taste_level: 0,
        bottle_option: false,
        nicotine: true,
        star: 2
      },
       {
        user_id: 5,
        title: "煙の国のアリス",
        body: "閉店しました。。",
        flavor_genre: 2,
        player: 0,
        location: "渋谷",
        hms_genre: 0,
        top_genre: 0,
        duration: 120,
        price: 3000,
        flavor_capacity: 12,
        flavor_maker: "ブタ",
        smoking_level: 1,
        smoking_taste_level: 1,
        bottle_option: false,
        nicotine: true,
        star: 3
      },
       {
        user_id: 6,
        title: "ちるこれ",
        body: "最近美味くなったようです。",
        flavor_genre: 2,
        player: 0,
        location: "表参道",
        hms_genre: 0,
        top_genre: 1,
        duration: 120,
        price: 1500,
        flavor_capacity: 12,
        flavor_maker: "アルファーヘル",
        smoking_level: 2,
        smoking_taste_level: 2,
        bottle_option: true,
        nicotine: true,
        star: 3
      },
    ]
  )
  
  PostComment.create!(
    [
      {
        user_id: 1,
        post_id: 1,
        comment: "この間店長が変わったようです。",
      },
      {
        user_id: 2,
        post_id: 3,
        comment: "一度はいってみたい！",
      },
    ]
  )
  
  Favorite.create!(
    [
      {
        user_id: 1,
        post_id: 2,
      },
      {
        user_id: 1,
        post_id: 3,
      },
    ]
  )
  
  Relationship.create!(
    [
      {
        follower_id: 1,
        followed_id: 2,
      },
      {
        follower_id: 2,
        followed_id: 1,
      },
      {
        follower_id: 3,
        followed_id: 1,
      },
      {
        follower_id: 1,
        followed_id: 4,
      },
      {
        follower_id: 1,
        followed_id: 5,
      },
      {
        follower_id: 3,
        followed_id: 2,
      },
    ]
  )
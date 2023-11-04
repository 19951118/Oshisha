class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :favorites,dependent: :destroy
  belongs_to :user
  has_one_attached :post_image
  
  validates :title, presence:true
  validates :text, length: { maximum: 300 }
  validates :flavor_genre, presence:true
  validates :player, presence:true
  validates :location, length: { maximum: 50 }
  validates :duration, numericality: { less_than_or_equal_to: 999}
  validates :price, numericality: { less_than_or_equal_to: 9999}
  validates :flavor_capacity, numericality: { less_than_or_equal_to: 99}
  validates :flavor_maker, length: { maximum: 70 }
  validates :smoking_level, presence:true
  validates :smoking_taste_level, presence:true
  validates :bottle_option, presence:true
  validates :nicotine, presence:true
  validates :star, presence:true
  
    #indexの並び順を変更する。descが昇順、escが降順。
  scope :latest, -> {order(created_at: :desc)} #最新-データ取り出し-作成日時
  scope :old, -> {order(created_at: :asc)} #最古-データ取り出し-作成日時
  scope :star_count, -> {order(star: :desc)} #星の多さ-データ取り出し-starカラム
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end

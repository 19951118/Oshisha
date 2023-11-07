class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :favorites,dependent: :destroy
  belongs_to :user
  has_one_attached :post_image

  enum flavor_genre: { fruits: 0, sweets: 1, tea: 2, flower: 3, drink: 4, wood: 5, spice: 6, other: 7 }
  enum player: { stores: 0, myself: 1 }
  enum hms_genre: { turkish: 0, lotus: 1, sream_ration: 2, amavost: 3, direct: 4, other_hms: 5 }
  enum top_genre: { straight: 0, funnel: 1, vortex: 2, fruit_top: 3, other_top: 4 }
  enum smoking_level: { strong_smoke: 0, normal_smoke: 1, light_smoke: 2 }
  enum smoking_taste_level: { strong_taste: 0, normal_taste: 1, light_taste: 2 }

  validates :title, presence:true
  validates :body, length: { maximum: 300 }
  validates :flavor_genre, presence:true
  validates :player, presence:true
  validates :location, length: { maximum: 50 }
  validates :duration, numericality: { less_than_or_equal_to: 999, allow_blank: true}
  validates :price, numericality: { less_than_or_equal_to: 9999, allow_blank: true}
  validates :flavor_capacity, numericality: { less_than_or_equal_to: 99, allow_blank: true}
  validates :flavor_maker, length: { maximum: 70 }
  validates :star, presence:true

    #indexの並び順を変更する。descが昇順、escが降順。
  scope :latest, -> {order(created_at: :desc)} #最新-データ取り出し-作成日時
  scope :old, -> {order(created_at: :asc)} #最古-データ取り出し-作成日時
  scope :star_count, -> {order(star: :desc)} #星の多さ-データ取り出し-starカラム

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image-icon.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no-image-icon.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
end

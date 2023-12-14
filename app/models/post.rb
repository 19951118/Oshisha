class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :favorites,dependent: :destroy
  belongs_to :user

  enum flavor_genre: { fruits: 0, sweets: 1, tea: 2, flower: 3, drink: 4, wood: 5, spice: 6, other: 7 }
  enum player: { stores: 0, myself: 1 }
  enum hms_genre: { turkish: 0, lotus: 1, sream_ration: 2, amavost: 3, direct: 4, other_hms: 5 }
  enum top_genre: { straight: 0, funnel: 1, vortex: 2, fruit_top: 3, other_top: 4 }
  enum smoking_level: { strong_smoke: 0, normal_smoke: 1, light_smoke: 2 }
  enum smoking_taste_level: { strong_taste: 0, normal_taste: 1, light_taste: 2 }

  validates :title, presence:true, length: { maximum: 15 }
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
  default_scope -> {order(created_at: :desc)}
  scope :latest, -> {reorder(created_at: :desc)} #最新-データ取り出し-作成日時
  scope :old, -> {reorder(created_at: :asc)} #最古-データ取り出し-作成日時
  scope :star_count, -> {reorder(star: :desc)} #星の多さ-データ取り出し-starカラム
  scope :favorite_count, -> { left_joins(:favorites).group(:id).reorder('COUNT(favorites.id) DESC') }
  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:title])
      .star_is(search_params[:star])
      .price_range(search_params[:price_from], search_params[:price_to])
      .player_is(search_params[:player])
      .flavor_genre_is(search_params[:flavor_genre])
      .bottle_option_is(search_params[:bottle_option])
      .nicotine_is(search_params[:nicotine])
      .smoking_level_is(search_params[:smoking_level])
      .smoking_taste_level_is(search_params[:smoking_taste_level])
      .hms_genre_is(search_params[:hms_genre])
      .top_genre_is(search_params[:top_genre])
      .location_like(search_params[:location])
      .duration_range(search_params[:duration_from], search_params[:duration_to])
      .flavor_capacity_range(search_params[:flavor_capacity_from], search_params[:flavor_capacity_to])
      .flavor_maker_like(search_params[:flavor_maker])
  end

  scope :name_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :star_is, -> (star) { where(star: star) if star.present? }
  scope :price_range, -> (from, to) { where(price: from..to) if from.present? && to.present? }
  scope :player_is, -> (player) { where(player: player) if player.present? }
  scope :flavor_genre_is, -> (flavor_genre) { where(flavor_genre: flavor_genre) if flavor_genre.present? }
  scope :bottle_option_is, -> (bottle_option) { where(bottle_option: bottle_option) if bottle_option.present? }
  scope :nicotine_is, -> (nicotine) { where(nicotine: nicotine) if nicotine.present? }
  scope :smoking_level_is, -> (smoking_level) { where(smoking_level: smoking_level) if smoking_level.present? }
  scope :smoking_taste_level_is, -> (smoking_taste_level) { where(smoking_taste_level: smoking_taste_level) if smoking_taste_level.present? }
  scope :hms_genre_is, -> (hms_genre) { where(hms_genre: hms_genre) if hms_genre.present? }
  scope :top_genre_is, -> (top_genre) { where(top_genre: top_genre) if top_genre.present? }
  scope :location_like, -> (location) { where('location LIKE ?', "%#{location}%") if location.present? }
  scope :duration_range, -> (from, to) { where(duration: from..to) if from.present? && to.present? }
  scope :flavor_capacity_range, -> (from, to) { where(flavor_capacity: from..to) if from.present? && to.present? }
  scope :flavor_maker_like, -> (flavor_maker) { where('flavor_maker LIKE ?', "%#{flavor_maker}%") if flavor_maker.present? }

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

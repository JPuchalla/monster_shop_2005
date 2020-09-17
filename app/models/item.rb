class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_presence_of :image, :allow_blank => true
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0


  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.top_five_items
    joins(:item_orders)
    .select('items.id', 'sum(item_orders.quantity) AS total', 'items.name')
    .group('items.id')
    .order('total desc')
    .limit(5)
  end

  def self.five_least_popular_items
    joins(:item_orders)
    .select('items.id', 'sum(item_orders.quantity) AS total', 'items.name')
    .group('items.id')
    .order('total asc')
    .limit(5)
  end

  def enable
    update(active?: true)
  end

  def disable
    update(active?: false)
  end

end

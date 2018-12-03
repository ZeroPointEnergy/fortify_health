require "granite/adapter/pg"
require "crypto/bcrypt/password"

class User < Granite::Base
  include Crypto
  adapter pg
  table_name users

  primary id : Int64
  field name : String
  field email : String
  field hashed_password : String
  field timezone : String
  field twenty_four_hour_clock : Bool
  timestamps

  has_many :recipes, class_name: Recipe
  has_many :products, class_name: Product
  has_many :meals, class_name: Meal
  has_many :product_source_subscriptions, class_name: ProductSourceSubscription

  after_destroy :cleanup

  def cleanup
    recipes.each(&.destroy)
    products.each(&.destroy)
    meals.each(&.destroy)
    product_source_subscriptions.each(&.destroy)
  end

  def product_sources_with_subscription
    subscriptions = product_source_subscriptions
    res = {} of ProductSource => ProductSourceSubscription?
    ProductSource.all.each do |product_source|
      res[product_source] = subscriptions.find do |subscription|
        subscription.product_source_id == product_source.id
      end
    end
    res
  end

  def products_in_groups
    res = {} of String => Array(Product)
    res["My Products"] = products.to_a
    product_source_subscriptions.each do |subscription|
      product_source = subscription.product_source
      if name = product_source.name
        res[name] = product_source.products.to_a
      end
    end
    res
  end

  def location
    Time::Location.load(timezone || "UTC")
  end

  def time_now
    Time.now(location)
  end

  def date_format
    "%Y-%m-%d"
  end

  def time_format
    twenty_four_hour_clock ? "%H:%M:%S" : "%I:%M:%S %p"
  end

  def format_date(time : Time?)
    if time
      time.in(location).to_s(date_format)
    else
      time_now.to_s(date_format)
    end
  end

  def format_time(time : Time?)
    if time
      time.in(location).to_s(time_format)
    else
      time_now.to_s(time_format)
    end
  end

  def parse_time(date : String, time : String)
    Time.parse("#{date} #{time}", "#{date_format} #{time_format}", location: location)
  end

  validate :email, "is required", ->(user : User) do
    (email = user.email) ? !email.empty? : false
  end

  validate :email, "already in use", ->(user : User) do
    existing = User.find_by email: user.email
    existing ? (user.id == existing.id) : false
  end

  validate :password, "is too short", ->(user : User) do
    user.password_changed? ? user.valid_password_size? : true
  end

  def password=(password)
    @new_password = password
    @hashed_password = Bcrypt::Password.create(password, cost: 10).to_s
  end

  def password
    (hash = hashed_password) ? Bcrypt::Password.new(hash) : nil
  end

  def password_changed?
    new_password ? true : false
  end

  def valid_password_size?
    (pass = new_password) ? pass.size >= 8 : false
  end

  def authenticate(password : String)
    (bcrypt_pass = self.password) ? bcrypt_pass == password : false
  end

  private getter new_password : String?
end

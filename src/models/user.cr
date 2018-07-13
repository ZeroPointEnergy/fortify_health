require "granite/adapter/pg"
require "crypto/bcrypt/password"

class User < Granite::Base
  include Crypto
  adapter pg
  primary id : Int64
  field name : String
  field email : String
  field hashed_password : String
  timestamps

  has_many :recipes
  has_many :products
  has_many :meals
  has_many :product_source_subscriptions

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

  def meals_by_days
    res = {} of String => Array(Meal)
    Meal.all("WHERE user_id = ? ORDER BY time DESC", id).each do |meal|
      res[meal.date_input] ||= [] of Meal
      res[meal.date_input] << meal
    end
    res
  end

  validate :email, "is required", ->(user : User) do
    (email = user.email) ? !email.empty? : false
  end

  validate :email, "already in use", ->(user : User) do
    existing = User.find_by email: user.email
    !existing
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

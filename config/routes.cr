Amber::Server.configure do
  pipeline :web do
    # Plug is the method to use connect a pipe (middleware)
    # A plug accepts an instance of HTTP::Handler
    plug Amber::Pipe::PoweredByAmber.new
    # plug Amber::Pipe::ClientIp.new(["X-Forwarded-For"])
    plug Citrine::I18n::Handler.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug Amber::Pipe::CSRF.new
    plug Authenticate.new
  end

  pipeline :api do
    plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::CORS.new
  end

  # All static content will run these transformations
  pipeline :static do
    plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  routes :web do
    resources "/products", ProductController
    resources "/recipes", RecipeController
    resources "/recipes/:recipe_id/ingrediants", IngrediantController, except: [:index, :show]
    resources "/meals", MealController
    resources "/meals/:meal_id/dishes", DishController, only: [:new, :create, :destroy]
    resources "/meals/:meal_id/side_dishes", SideDishController, except: [:index, :show]
    resources "/product_sources", ProductSourceController, only: [:index, :show]
    resources "/product_sources/:product_source_id/subscriptions", ProductSourceSubscriptionController, only: [:create, :destroy]
    get "/profile", UserController, :show
    get "/profile/edit", UserController, :edit
    patch "/profile", UserController, :update
    get "/signin", SessionController, :new
    post "/session", SessionController, :create
    get "/signout", SessionController, :delete
    get "/signup", RegistrationController, :new
    post "/registration", RegistrationController, :create
    get "/", HomeController, :index
  end

  routes :api do
  end

  routes :static do
    # Each route is defined as follow
    # verb resource : String, controller : Symbol, action : Symbol
    get "/*", Amber::Controller::Static, :index
  end
end

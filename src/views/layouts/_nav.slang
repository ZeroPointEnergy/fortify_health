- active = context.request.path == "/" ? "active" : ""
a class="nav-item #{active}" href="/" Home
- if (current_user = context.current_user)
  a.nav-item.nav-item-auth.nav-item-auth-signout href="/signout"
    | Sign Out
  - active = context.request.path == "/profile" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-profile #{active}" href="/profile"
    == current_user.email
  - active = context.request.path == "/meals" ? "active" : ""
  a class="nav-item #{active}" href="/meals" Meals
  - active = context.request.path == "/recipes" ? "active" : ""
  a class="nav-item #{active}" href="/recipes" My Recipes
  a class="nav-item dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" Products
  div class="dropdown-menu" aria-labelledby="navbarDropdown"
    a class="dropdown-item" href="/products" My Products
    a class="dropdown-item" href="/product_sources" Product Sources
- else
  - active = context.request.path == "/signup" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-signup #{active}" href="/signup"
    | Sign Up
  - active = context.request.path == "/signin" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-signin #{active}" href="/signin"
    | Sign In

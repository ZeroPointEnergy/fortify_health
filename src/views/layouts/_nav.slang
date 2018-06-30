- active = context.request.path == "/" ? "active" : ""
a class="nav-item #{active}" href="/" Home
- if (current_user = context.current_user)
  a.nav-item.nav-item-auth.nav-item-auth-signout href="/signout"
    | Sign Out
  - active = context.request.path == "/profile" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-profile #{active}" href="/profile"
    == current_user.email
- else
  - active = context.request.path == "/signup" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-signup #{active}" href="/signup"
    | Sign Up
  - active = context.request.path == "/signin" ? "active" : ""
  a class="nav-item nav-item-auth nav-item-auth-signin #{active}" href="/signin"
    | Sign In
- active = context.request.path == "/nutrition_facts" ? "active" : ""
a class="nav-item #{active}" href="/nutrition_facts" Nutrition Facts
- active = context.request.path == "/recipes" ? "active" : ""
a class="nav-item #{active}" href="/recipes" Recipes
- active = context.request.path == "/products" ? "active" : ""
a class="nav-item #{active}" href="/products" Products
- active = context.request.path == "/ingrediants" ? "active" : ""
a class="nav-item #{active}" href="/ingrediants" Ingrediants

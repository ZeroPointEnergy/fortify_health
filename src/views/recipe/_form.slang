- if recipe.errors
  ul.errors
    - recipe.errors.each do |error|
      li = error.to_s

== form(action: "/recipes/#{recipe.id.to_s}", method: recipe.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "name", value: recipe.name, placeholder: "Name", class: "form-control")
  .form-group
    == label(:user)
    == select_field(name: "user_id", collection: User.all.map{|user| [user.id, user.id]}, selected: recipe.user_id, class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/recipes", class: "btn btn-light btn-sm")

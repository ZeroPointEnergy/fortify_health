- if meal.errors
  ul.errors
    - meal.errors.each do |error|
      li = error.to_s

== form(action: "/meals/#{meal.id.to_s}", method: meal.id ? :patch : :post) do
  == csrf_tag
  .form-group
     input type="text" name="date" value=user.format_date(meal.time) id="date" class="form-control"
  .form-group
    input type="text" name="time" value=user.format_time(meal.time) id="time" class="form-control"

  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/meals", class: "btn btn-light btn-sm")

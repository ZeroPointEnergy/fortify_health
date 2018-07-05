- if meal.errors
  ul.errors
    - meal.errors.each do |error|
      li = error.to_s

== form(action: "/meals/#{meal.id.to_s}", method: meal.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "time", value: meal.time, placeholder: "Time", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/meals", class: "btn btn-light btn-sm")

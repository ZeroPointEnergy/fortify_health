h1 Edit Profile

- if user.errors
  ul.errors
  - user.errors.each do |error|
    li = error.to_s

== form(action: "/profile", method: :patch) do
  == csrf_tag
  .form-group
    input.form-control type="name" name="name" placeholder="Name" value="#{user.name}"
  .form-group
    input.form-control type="email" name="email" placeholder="Email" value="#{user.email}"
  .form-group
    == label("24h clock")
    == check_box(:twenty_four_hour_clock, checked: user.twenty_four_hour_clock)
  .form-group
    input.form-control type="timezone" name="timezone" placeholder="UTC" value="#{user.timezone}"
  == submit("Update", class: "btn btn-primary btn-sm")
  == link_to("profile", "/profile", class: "btn btn-light btn-sm")

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# admin = User.create(
#   email: "a@bc.de",
#   password: "123123123",
#   role: "admin"
# )

# berlin = City.create(
#   name: 'Berlin',
#   slug: 'berlin',
#   lat: 52.516,
#   lng: 13.383
# )

# kopi = Squat.new(
#   name: "Köpi",
#   slug: 'kopi',
#   city: berlin,
#   lat: 52.5077,
#   lng: 13.426
# )
# kopi.save(validate: false)
# Period.create(
#   start_year: 1990,
#   squat: kopi
# )

# tommy = Squat.new(
#   name: "Tommy-Weisbecker-Haus",
#   slug: "tommy-weisbecker-haus",
#   city: berlin,
#   lat: 52.5013,
#   lng: 13.389
# )
# tommy.save(validate: false)
# Period.create(
#   start_year: 1973,
#   start_month: 3,
#   squat: tommy
# )
#
User.create!(email: "admin@admin.de", password: "password1", password_confirmation: "password1", role: "admin" )
User.create!(email: "user@user.de", password: "password2", password_confirmation: "password2", role: "user" )

City.create!(name: "Berlin", body: "Grumpiest place on earth", lat: 52.5167, lng: 13.3833, slug: "berlin")
City.create!(name: "Freiburg", body: "Happiest place on earth", lat: 47.9833, lng: 7.8500, slug: "fribi")
period_1 = Period.create!(start_year: 1986, start_month: 4, start_day: 21, end_year: 2012, end_month: 7, end_day: 1)
period_2 = Period.create!(start_year: 2002, start_month: 5, start_day: 1, end_year: 2003, end_month: 6, end_day: 22)
period_3 = Period.create!(start_year: 2010, start_month: 1, start_day: 1, end_year: 2014, end_month: 9, end_day: 6)
squat_1 = Squat.new(name: "Da place to be", body: "The place to be until summer 2012", lat: 48.005045, lng: 7.852989 , city_id: 2, slug: "sautier", address: "Sautierstr. 29")
squat_2 = Squat.new(name: "Squat1", body: "bla", lat: 47.993535, lng: 7.846118 , city_id: 2, slug: "uni", address: "Fahnenbergplatz")
squat_3 = Squat.new(name: "Squat2", body: "asdf", lat: 52.476624, lng: 13.438721 , city_id: 1, slug: "karlmarx", address: "Karl-Marx-Str. 146")
squat_1.periods << period_1
squat_2.periods << period_2
squat_3.periods << period_3
squat_1.save
squat_2.save
squat_3.save


# tommy = Squat.new(
#   name: "Tommy-Weisbecker-Haus",
#   slug: "tommy-weisbecker-haus",
#   city: berlin,
#   lat: 52.5013,
#   lng: 13.389
# )
# tommy.save(validate: false)
# Period.create(
#   start_year: 1973,
#   start_month: 3,
#   squat: tommy
# )

squat_1.pictures.create({title: "Pic1", description: "Awesome pic", picture: "foo.jpg"})
squat_2.pictures.create({title: "pic2", description: "Awesome pic2", picture: "foo2.jpg"})


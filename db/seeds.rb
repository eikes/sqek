admin = User.create(
  email: "a@bc.de",
  password: "123123123",
  role: "admin"
)

berlin = City.create(
  name: 'Berlin',
  slug: 'berlin',
  lat: 52.516,
  lng: 13.383
)

kopi = Squat.new(
  name: "Köpi",
  slug: 'kopi',
  city: berlin,
  lat: 52.5077,
  lng: 13.426
)
kopi.save(validate: false)
Period.create(
  start_year: 1990,
  squat: kopi
)

tommy = Squat.new(
  name: "Tommy-Weisbecker-Haus",
  slug: "tommy-weisbecker-haus",
  city: berlin,
  lat: 52.5013,
  lng: 13.389
)
tommy.save(validate: false)
Period.create(
  start_year: 1973,
  start_month: 3,
  squat: tommy
)

kopi.pictures.create({title: "Pic1", description: "Awesome pic", picture: "foo.jpg"})
tommy.pictures.create({title: "pic2", description: "Awesome pic2", picture: "foo2.jpg"})
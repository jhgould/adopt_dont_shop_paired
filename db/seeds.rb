# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter = Shelter.create(name: "Angels With Paws", address: "2540 Youngfield St", city: "Lakewood", state: "CO", zip: "80215")
shelter2 = Shelter.create(name: "MaxFund Dog Shelter", address: "1005 Galapago", city: "Denver", state: "CO", zip: "80204")
shelter3 = Shelter.create(name: "Lakwood Shelter", address: "1005 Colfax", city: "Lakewood", state: "CO", zip: "80215")
shelter.pets.create!(
  image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
  name: "Bruno",
  approximate_age: "4",
  sex: "M",)
shelter.pets.create!(
  image_path: "https://images.pexels.com/photos/2023384/pexels-photo-2023384.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  name: "Woody",
  approximate_age: "2",
  sex: "F",)
shelter2.pets.create!(
  image_path: "https://images.pexels.com/photos/59523/pexels-photo-59523.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
  name: "Jim",
  approximate_age: "2",
  sex: "F",
  adoption_status: false,)
shelter2.pets.create!(
  image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
  name: "Koa",
  approximate_age: "2",
  sex: "F",)
shelter2.pets.create!(
  image_path: "https://images.pexels.com/photos/1485637/pexels-photo-1485637.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  name: "Spike",
  approximate_age: "2",
  sex: "M",)
shelter3.pets.create!(
  image_path: "https://images.pexels.com/photos/1564506/pexels-photo-1564506.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  name: "Stinky",
  approximate_age: "7",
  sex: "F",)
shelter.reviews.create!(
                        title: "Great",
                        rating: 5,
                        content: "This place was awesome",
                        image_path: "https://media11.s-nbcnews.com/j/MSNBC/Components/Video/202003/DogAdoptionThumbnail.focal-760x428.jpg"  )
shelter2.reviews.create!(
                        title: "good",
                        rating: 3,
                        content: "This place was ehh",
                        )

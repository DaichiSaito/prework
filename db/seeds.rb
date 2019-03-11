require 'csv'

csv = CSV.read('db/fixtures/development/hotels.csv')

csv.each_with_index do |hotel, i|
  # skip a label row
  next if i === 0

  hotel_id = hotel[0]
  hotel_name = hotel[1]
  hotel_caption = hotel[2]
  image_uri = hotel[3]

  Hotel.seed do |s|
    s.id   = i
    s.hotel_id = hotel_id
    s.hotel_name = hotel_name
    s.hotel_caption = hotel_caption
    s.image_uri = image_uri
  end
end

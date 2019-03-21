# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do |i|
  User.create(user_name:"ユーザー #{i}", user_name_kana:"ゆーざー", 
              email:"test#{i}@gmail.com", postcode:"1112222", 
              address:"東京都江戸川区", phone_number:"0377778888", password:"password")
  Cart.create(user_id:i)
end

Genre.create(genre_name:"Rock")
Genre.create(genre_name:"Pop")
Genre.create(genre_name:"Punk")

5.times do |i|
  Label.create(label_name:"レーベル #{i}")
end

5.times do |i|
  Artist.create(artist_name:"アーティスト #{i}")
end

15.times do |i|
  Product.create(product_title:"CD名 #{i}", product_price: 1000*i, 
                  label_id: 1, genre_id: 1, explanation: "テストですよ。長文打てません。", stock: i)
end


15.times do |p|
  2.times do |i|
    5.times do |j|
      Song.create(song_title:"ディスク#{i}の#{j}番目", artist_id: 1, 
                  track_order: j, product_id: p, disk_number: i)
    end
  end
end

2.times do |i|
  Destination.create(destination_name:"送付先#{i}", destination_postcode:"5559999",
                      destination_address:"愛知県名古屋市", user_id: 1)
end

User.create!(user_name: "admin",
            user_name_kana: "あどみん",
            email: 'admin@nozomi.com',
            postcode: "0010922",
            phone_number: "09013078353",
            address: "4-9-5",
            password: 'admin.com',
            password_confirmation: 'admin.com' ,
            admin: true)

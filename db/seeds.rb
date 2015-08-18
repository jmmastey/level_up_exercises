# WARNING!! If you modify this file, do NOT add Radiohead or Mixtapes.
# There is a test that is dependent on those not being present in the database.
# Create Black Sabbath
json = "{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/5M52tdBnJaKSvOpJGz8mfZ\"},\"followers\":{\"href\":null,\"total\":489996},\"genres\":[],\"href\":\"https://api.spotify.com/v1/artists/5M52tdBnJaKSvOpJGz8mfZ\",\"id\":\"5M52tdBnJaKSvOpJGz8mfZ\",\"images\":[{\"height\":1333,\"url\":\"https://i.scdn.co/image/181409237e2bb85b981a9218af384606efc99f5b\",\"width\":1000},{\"height\":853,\"url\":\"https://i.scdn.co/image/e8ea8fe7b8cbe77b13a1b03f95388a1291bc722f\",\"width\":640},{\"height\":267,\"url\":\"https://i.scdn.co/image/f607f2c3fe242cd4a299aea1f8db0b97073e59ab\",\"width\":200},{\"height\":85,\"url\":\"https://i.scdn.co/image/ca72a97d0ba53b436dd0b1dcf9201710389d89b2\",\"width\":64}],\"name\":\"Black Sabbath\",\"popularity\":75,\"type\":\"artist\",\"uri\":\"spotify:artist:5M52tdBnJaKSvOpJGz8mfZ\"}"
related = [
  'Ozzy Osbourne',
  'Judas Priest',
  'Dio',
  'Iron Maiden',
  'Motörhead',
  'Danzig',
  'Deep Purple',
  'Thin Lizzy',
  'KISS',
  'Saxon',
  'Heaven & Hell',
  'AC/DC',
  'Rainbow',
  'Metallica',
  'Bruce Dickinson',
  'Tony Iommi',
  'UFO',
  'Diamond Head',
  'Alice Cooper',
  'Uriah Heep',
]
Artist.create(name: 'Black Sabbath', json: json, related: related)

# Create Ozzy
json = "{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/6ZLTlhejhndI4Rh53vYhrY\"},\"followers\":{\"href\":null,\"total\":341024},\"genres\":[],\"href\":\"https://api.spotify.com/v1/artists/6ZLTlhejhndI4Rh53vYhrY\",\"id\":\"6ZLTlhejhndI4Rh53vYhrY\",\"images\":[{\"height\":1333,\"url\":\"https://i.scdn.co/image/143569b499e849bf53a944ef58736fd25c2c27aa\",\"width\":1000},{\"height\":853,\"url\":\"https://i.scdn.co/image/58a477aa79e4ce8b108bf265e8184602b20a38e7\",\"width\":640},{\"height\":267,\"url\":\"https://i.scdn.co/image/0720e12210764dab2abdc7aaf8520bad9aaa3c71\",\"width\":200},{\"height\":85,\"url\":\"https://i.scdn.co/image/98d9ba342ec6e51ce270c73adcd1d31099a4eb83\",\"width\":64}],\"name\":\"Ozzy Osbourne\",\"popularity\":73,\"type\":\"artist\",\"uri\":\"spotify:artist:6ZLTlhejhndI4Rh53vYhrY\"}"
related = [
  'Black Sabbath',
  'Dio',
  'Judas Priest',
  'KISS',
  'Iron Maiden',
  'Twisted Sister',
  'Alice Cooper',
  'Scorpions',
  'Whitesnake',
  'Mötley Crüe',
  'Rainbow',
  'Bruce Dickinson',
  'Deep Purple',
  'Skid Row',
  'AC/DC',
  'Queensrÿche',
  'Motörhead',
  'Saxon',
  'Quiet Riot',
  '"Ugly Kid Joe',
]
Artist.create(name: 'Ozzy Osbourne', json: json, related: related)

# Create Dio
json = "{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/4CYeVo5iZbtYGBN4Isc3n6\"},\"followers\":{\"href\":null,\"total\":144290},\"genres\":[\"hard rock\",\"metal\"],\"href\":\"https://api.spotify.com/v1/artists/4CYeVo5iZbtYGBN4Isc3n6\",\"id\":\"4CYeVo5iZbtYGBN4Isc3n6\",\"images\":[{\"height\":815,\"url\":\"https://i.scdn.co/image/db568718cf8545bb862a1047f94162f68f616f6d\",\"width\":1000},{\"height\":522,\"url\":\"https://i.scdn.co/image/1c262b16c75878b662461e0f16fee102ac1a5c2c\",\"width\":640},{\"height\":163,\"url\":\"https://i.scdn.co/image/c84371d67dacdb7778a231cd70751f2f2040c869\",\"width\":200},{\"height\":52,\"url\":\"https://i.scdn.co/image/abe0bc5fabac30cfb8159d0145d0e9fbf490c57c\",\"width\":64}],\"name\":\"Dio\",\"popularity\":65,\"type\":\"artist\",\"uri\":\"spotify:artist:4CYeVo5iZbtYGBN4Isc3n6\"}"
related = [
  'Judas Priest',
  'Black Sabbath',
  'Iron Maiden',
  'Ronnie James Dio',
  'Bruce Dickinson',
  'Ozzy Osbourne',
  'Rainbow',
  'Saxon',
  'Accept',
  'Heaven & Hell',
  'Queensrÿche',
  'W.A.S.P.',
  'Scorpions',
  'Motörhead',
  'Manowar',
  'KISS',
  'Twisted Sister',
  'Savatage',
  'UFO',
  'Diamond Head',
]
Artist.create(name: 'Dio', json: json, related: related)

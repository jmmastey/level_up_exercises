json.twitter @artist.fan_metrics("Twitter"), :value, :unix_time
json.facebook @artist.fan_metrics("Facebook"), :value, :unix_time
json.youtube @artist.fan_metrics("YouTube"), :value, :unix_time
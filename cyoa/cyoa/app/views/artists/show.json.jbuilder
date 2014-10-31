json.extract! @artist, :name
json.twitter @artist.graph_metrics("Twitter")
#json.facebook @artist.fan_metrics("Facebook"), :unix_time, :value
#json.youtube @artist.fan_metrics("YouTube"), :unix_time, :value
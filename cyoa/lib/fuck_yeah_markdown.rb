module FuckYeahMarkdown
  def self.request(url, readability)
    readability = readability ? "1" : "0"
    api_path = "http://fuckyeahmarkdown.com/go/?u=" +
      url + "&read=" + readability
    url = URI.parse(api_path)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    res.body
  end
end

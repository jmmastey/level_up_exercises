require 'net/http'
require 'nokogiri'

class CTA
  CTA_BASE_URL = "http://www.ctabustracker.com/bustime/api/v1/"

  attr_accessor :api_key, :test_var

  def initialize
    @api_key = ENV['CTA_API_KEY']
  end

  def load_routes
    doc = Nokogiri::XML(xml_request("getroutes"))
    # route_list = doc.xpath("//route")

    doc.xpath("//route").collect do |route_node|
      # puts route_node
      search_nodes = {
        rt:   :route_id,
        rtnm: :route_name,
      }
      compile_node_data(route_node.children, search_nodes)
    end

  end

  def load_direction(route_id = 0)
    options = { rt: route_id }
    doc = Nokogiri::XML(xml_request("getdirections", options))
    direction_list = doc.xpath("//dir")
    direction_list.collect do |route_node|
      route_node.text
    end
  end

  def load_stops(route_id = 0, route_direction = "")
    options = { rt: route_id, dir: route_direction }
    doc = Nokogiri::XML(xml_request("getstops", options))
    stop_list = doc.xpath("//stop")
    stop_list.collect do |route_node|
      search_nodes = {
        stpid: :stop_id,
        stpnm: :stop_name,
      }
      compile_node_data(route_node.children, search_nodes)
    end
  end

  def load_stop_eta(stop_id = 0, route_id = 0)
    options = { stpid: stop_id }
    unless route_id == 0
      options[:rt] = route_id
    end
    doc = Nokogiri::XML(xml_request("getpredictions", options))
    stop_list = doc.xpath("//prd")
    stop_list.collect do |route_node|
      search_nodes = {
        stpnm:  :stop_name,
        stpid:  :stop_id,
        vid:    :vehicle_id,
        rt:     :route_id,
        des:    :destination,
        prdtm:  :eta_stamp,
      }
      data = compile_node_data(route_node.children, search_nodes)
      data[:eta_time] = minute_difference(data[:eta_stamp].split(" ")[1])

      # data[:milirary_time] = data[:eta_stamp].split(" ")[1]
      # data[:utc_offset] = utc_offset
      # data[:time_now] = DateTime.now().utc
      # data[:bus_time_to_parse] = "#{data[:eta_stamp].split(" ")[1]} #{utc_offset}"
      # data[:bus_time] = DateTime.parse("#{data[:eta_stamp].split(" ")[1]} #{utc_offset}").utc
      data
    end
  end

  private

  def minute_difference(military_time)
    time = DateTime.parse("#{military_time} #{utc_offset}")
    (((time.utc - DateTime.now().utc) * 24 ) * 60 ).to_i
  end

  def utc_offset
    Time.now.strftime("%z")
  end

  def compile_node_data(nodes, search_meta)
    nodes.each_with_object({}) do |node, data|
      meta_key = search_meta[node.name.to_sym]
      unless meta_key == nil
        data[meta_key] = node.text
      end
    end
  end

  def xml_request(url_path, options = {})
    options.merge!(key: api_key)
    url = URI.parse("#{CTA_BASE_URL}#{url_path}/?#{options.to_query}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body
  end
end

class IndexController < ApplicationController
  require 'net/http'
  require 'json'

  class UserData
    attr_accessor :keys, :clicks, :download, :upload, :uptime, :country, :team

    def initialize(json_string)
      data_object = JSON.parse(json_string)

      @keys = data_object['Keys']
      @clicks = data_object['Clicks']
      @download = data_object['DownloadMB']
      @upload = data_object['UploadMB']
      @uptime = data_object['UptimeSeconds']
      @country = data_object['tld']
      @team = {
        name: data_object['Team']['Name'],
        keys: data_object['Team']['Keys'],
        clicks: data_object['Team']['Clicks'],
        download: data_object['Team']['DownloadMB'],
        upload: data_object['Team']['UploadMB'],
        uptime: data_object['Team']['UptimeSeconds']
      }
    end
  end

  def index
    @user1 = params[:user1] || 'igmas'
    @user2 = params[:user2] || 'avrex'
  end

  def poll
    @user1 = params[:user1] || 'igmas'
    @user2 = params[:user2] || 'avrex'

    user1_data = poll_external_api(@user1)
    user2_data = poll_external_api(@user2)

    results = [user1_data, user2_data]

    render json: results.to_json
  end

  private
  def poll_external_api(user_name)
    external_route =
      URI.parse("http://api.whatpulse.org/user.php?user=#{user_name}&format=json")

    api_request = Net::HTTP::Get.new(external_route)
    api_response = Net::HTTP.start(external_route.host, external_route.port) do |http|
      http.request(api_request)
    end

    UserData.new(api_response.body)
  end
end

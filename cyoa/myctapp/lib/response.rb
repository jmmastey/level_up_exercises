class Response

  def self.Json(status, message = "", data = nil)
    if data.nil?
      return { json: { status: status, message: message } }
    end
    { json: { status: status, message: message }.merge(data) }
  end
end

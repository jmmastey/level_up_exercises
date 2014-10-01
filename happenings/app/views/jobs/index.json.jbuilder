json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :location, :link, :haveapplied, :company, :interested, :referred
  json.url job_url(job, format: :json)
end

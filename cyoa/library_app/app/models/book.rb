class Book < ActiveRecord::Base
  validates(:title, presence: true)

  def query_api(search_params)
    results = CallClassifyAPI.query_api(search_params, true)
    CallClassifyAPI.delegate_output(results)
end

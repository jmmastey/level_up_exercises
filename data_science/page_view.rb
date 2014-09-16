class PageView
  attr_reader :date, :purchased, :id

  def initialize(params)
    @date = params[:date]
    @purchased = params[:purchased]
    @id = params[:id]
  end
end

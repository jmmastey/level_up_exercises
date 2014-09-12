class PageView
  attr_reader :date, :purchase, :id
  def initialize(params)
    @date = params[:date]
    @purchase = params[:purchase]
    @id = params[:id]
  end
end

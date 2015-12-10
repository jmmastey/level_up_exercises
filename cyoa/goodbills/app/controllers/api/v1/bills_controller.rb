class Api::V1::BillsController < ApplicationController
  def index
    @bills = Bill.first(10)
  end
end

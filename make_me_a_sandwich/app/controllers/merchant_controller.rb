class MerchantController < ApplicationController
  before_action :authenticate_user!

  def search
    raise NotImplementedError, "Action not implemented yet."
  end
end

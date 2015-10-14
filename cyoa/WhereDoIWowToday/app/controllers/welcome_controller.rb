class WelcomeController < ApplicationController
  def index
    flash[:error] = Realm.refresh
    @realms = Realm.all.map(&:name)
  end
end

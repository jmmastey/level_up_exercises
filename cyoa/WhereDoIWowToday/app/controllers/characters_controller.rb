class CharactersController < ApplicationController
  def index
    if specific_character_requested?
      refresh_requested_character
      update_notice_with_character_validation
      redirect_to @character unless @character.nil?
    end
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
    Character.refresh_individual(name: @character.name, realm: @character.realm)
    @zone_summaries = @character.zone_summaries
  end

  private

  def specific_character_requested?
    name = params['Name']
    realm = params['Realm']
    name && !name.empty? && realm && !realm.empty?
  end

  def refresh_requested_character
    @character = Character.refresh_individual(
      name: params['Name'].titleize, realm: params['Realm'])
  end

  def update_notice_with_character_validation
    if @character.nil?
      flash[:notice] = "Character does not exist"
    else
      flash.delete :notice
    end
  end
end

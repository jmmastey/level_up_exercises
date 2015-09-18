class CharactersController < ApplicationController
  def index
    @characters = Character.all
    go_to_character if specific_character_requested?
  end

  def show
    @character = Character.find(params[:id])
    Character.refresh_individual(name: @character.name, realm: @character.realm)
    @zone_summaries = @character.zone_summaries
  end

  private

  def specific_character_requested?
    name = params['Name']
    return true if name && !name.empty?
    realm = params['Realm']
    realm && !realm.empty?
  end

  def go_to_character
    @character = Character.refresh_individual(name: params['Name'].titleize,
                                              realm: params['Realm'])
    if @character.nil?
      flash[:notice] = "Character does not exist"
    else
      redirect_to @character
    end
  end
end

# app/controllers/animals_controller.rb
class AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  # GET /animals/:id
  def show
    @animal = Animal.find(params[:id]) # Récupère l'animal par ID
  end
end

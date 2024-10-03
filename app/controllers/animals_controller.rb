class AnimalsController < ApplicationController
  # GET /animals
  # Cette action récupère tous les animaux dans la base de données et les stocke dans la variable @animals.
  def index
    @animals = Animal.all
  end

  # GET /animals/:id
  # Cette action affiche les détails d'un animal spécifique en le récupérant par son ID.
  def show
    @animal = Animal.find(params[:id]) # Récupère l'animal par ID
  end

  # GET /animals/new
  # Cette action initialise un nouvel objet Animal vide pour le formulaire de création.
  def new
    @animal = Animal.new
  end

  # POST /animals
  # Cette action traite les données soumises via le formulaire de création d'un animal.
  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      redirect_to @animal, notice: 'Animal créé avec succès.'
    else
      render :new
    end
  end

  private

  # Méthode privée pour définir les paramètres autorisés pour un animal.
  def animal_params
    params.require(:animal).permit(:name, :species, :breed, :color, :weight, :dateOfBirth, :owner_id)
  end
end

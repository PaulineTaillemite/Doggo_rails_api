class AnimalsController < ApplicationController
  # Avant d'exécuter certaines actions (show, edit, update, destroy), on appelle la méthode `set_animal`
  # Cette méthode permet de récupérer l'animal concerné en fonction de l'ID passé dans l'URL.
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  # GET /animals
  # Cette action récupère tous les animaux dans la base de données et les stocke dans la variable `@animals`.
  # Si un paramètre de recherche est présent, elle filtre les résultats en fonction du nom.
  def index
    if params[:search].present?
      @animals = Animal.where('name LIKE ?', "%#{params[:search]}%")
    else
      @animals = Animal.all
    end
  end

  # GET /animals/:id
  # Cette action affiche les détails d'un animal spécifique. La méthode `set_animal` est appelée automatiquement avant
  # cette action pour récupérer l'animal concerné en fonction de son ID.
  def show
    # @animal est définie dans la méthode set_animal
  end

  # GET /animals/new
  # Cette action initialise un nouvel objet `Animal` vide qui sera utilisé dans la vue `new_animals.html.erb`
  # pour générer le formulaire de création d'un nouvel animal.
  def new
    @animal = Animal.new
  end

  # POST /animals
  # Cette action traite les données soumises via le formulaire de création d'un animal.
  # Si la création réussit (c'est-à-dire si les validations passent), l'animal est sauvegardé dans la base de données,
  # et l'utilisateur est redirigé vers la page de détail de l'animal (show). Sinon, on réaffiche le formulaire avec les erreurs.
  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      redirect_to @animal, notice: "Animal créé avec succès."
    else
      render :new_animals
    end
  end

  # GET /animals/:id/edit
  # Cette action affiche le formulaire d'édition d'un animal existant.
  # La méthode `set_animal` est utilisée pour charger l'animal à modifier.
  def edit
    # @animal est définie dans la méthode set_animal
  end

  # PATCH/PUT /animals/:id
  # Cette action traite les modifications soumises via le formulaire d'édition.
  # Si la mise à jour réussit, l'animal est modifié dans la base de données et l'utilisateur est redirigé
  # vers la page de détail de l'animal. Sinon, le formulaire est réaffiché avec les erreurs.
  def update
    if @animal.update(animal_params)
      redirect_to @animal, notice: "Animal mis à jour avec succès."
    else
      render :edit_animals
    end
  end

  # DELETE /animals/:id
  # Cette action permet de supprimer un animal de la base de données.
  # Une fois l'animal supprimé, l'utilisateur est redirigé vers la liste des animaux.
  def destroy
    @animal.destroy
    redirect_to animals_url, notice: "Animal supprimé avec succès."
  end

  private

  # Méthode privée pour récupérer un animal en fonction de l'ID passé dans l'URL.
  # Cette méthode est appelée avant les actions show, edit, update et destroy.
  def set_animal
    @animal = Animal.find(params[:id])
  end

  # Méthode privée qui définit les paramètres autorisés pour un animal.
  # Cela permet de protéger l'application contre des attaques en limitant les attributs
  # que l'on peut soumettre via les formulaires. Seuls :name, :species, :breed, :color, :weight, et :dateOfBirth sont autorisés.
  def animal_params
    params.require(:animal).permit(:name, :species, :breed, :color, :weight, :dateOfBirth)
  end
end

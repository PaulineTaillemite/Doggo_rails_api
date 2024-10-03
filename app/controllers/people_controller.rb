class PeopleController < ApplicationController
  # Avant d'exécuter certaines actions (show, edit, update, destroy), on appelle la méthode `set_person`
  # Cette méthode permet de récupérer la personne concernée en fonction de l'ID passé dans l'URL.
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # Cette action récupère toutes les personnes dans la base de données et les stocke dans la variable `@people`.
  # Si un paramètre de recherche est présent, elle filtre les résultats en fonction du prénom ou du nom de famille.
  def index
    if params[:search].present?
      @people = Person.where('firstName LIKE ? OR lastName LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @people = Person.all
    end
  end

  # GET /people/:id
  # Cette action affiche les détails d'une personne spécifique. La méthode `set_person` est appelée automatiquement avant
  # cette action pour récupérer la personne concernée en fonction de son ID.
  def show
    # @person est définie dans la méthode set_person
  end

  # GET /people/new
  # Cette action initialise un nouvel objet `Person` vide qui sera utilisé dans la vue `new_people.html.erb`
  # pour générer le formulaire de création d'une nouvelle personne.
  def new
    @person = Person.new
  end

  # POST /people
  # Cette action traite les données soumises via le formulaire de création d'une personne.
  # Si la création réussit (c'est-à-dire si les validations passent), la personne est sauvegardée dans la base de données,
  # et l'utilisateur est redirigé vers la page de détail de la personne (show). Sinon, on réaffiche le formulaire avec les erreurs.
  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: "Propriétaire créé avec succès."
    else
      render :new_people
    end
  end

  # GET /people/:id/edit
  # Cette action affiche le formulaire d'édition d'une personne existante.
  # La méthode `set_person` est utilisée pour charger la personne à modifier.
  def edit
    # @person est définie dans la méthode set_person
  end

  # PATCH/PUT /people/:id
  # Cette action traite les modifications soumises via le formulaire d'édition.
  # Si la mise à jour réussit, la personne est modifiée dans la base de données et l'utilisateur est redirigé
  # vers la page de détail de la personne. Sinon, le formulaire est réaffiché avec les erreurs.
  def update
    if @person.update(person_params)
      redirect_to @person, notice: "Propriétaire mis à jour avec succès."
    else
      render :edit_people
    end
  end

  # DELETE /people/:id
  # Cette action permet de supprimer une personne de la base de données.
  # Une fois la personne supprimée, l'utilisateur est redirigé vers la liste des personnes.
  def destroy
    @person.destroy
    redirect_to people_url, notice: "Propriétaire supprimé avec succès."
  end

  private

  # Méthode privée pour récupérer une personne en fonction de l'ID passé dans l'URL.
  # Cette méthode est appelée avant les actions show, edit, update et destroy.
  def set_person
    @person = Person.find(params[:id])
  end

  # Méthode privée qui définit les paramètres autorisés pour une personne.
  # Cela permet de protéger l'application contre des attaques en limitant les attributs
  # que l'on peut soumettre via les formulaires. Seuls :firstName, :lastName, :email et :phoneNumber sont autorisés.
  def person_params
    params.require(:person).permit(:firstName, :lastName, :email, :phoneNumber)
  end
end

require 'json'

# Lire le fichier JSON
file = File.read(Rails.root.join('db', 'data.json'))
data = JSON.parse(file)

# Créer les enregistrements pour les personnes
data['persons'].each do |person_data|
  Person.create(person_data)
end

# Créer les enregistrements pour les animaux
data['animals'].each do |animal_data|
  Animal.create(
    name: animal_data['name'],
    dateOfBirth: animal_data['dateOfBirth'],
    species: animal_data['species'],
    breed: animal_data['breed'],
    color: animal_data['color'],
    weight: animal_data['weight'],
    owner_id: animal_data['personId']  # Utiliser personId comme owner_id ici
  )
end

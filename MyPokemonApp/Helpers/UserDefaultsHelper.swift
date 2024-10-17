import Foundation

extension UserDefaults {
    private enum Keys {
        static let favoritePokemons = "favoritePokemons"
    }
    
    var favoritePokemons: [PokemonData] {
        get {
            guard let data = data(forKey: Keys.favoritePokemons) else { return [] }
            let decoder = JSONDecoder()
            do {
                let favorites = try decoder.decode([PokemonData].self, from: data)
                return favorites.sorted(by: { ($0.id ?? 0) < ($1.id ?? 0) })
            } catch {
                print("Failed to decode favoritePokemons: \(error)")
                return []
            }
        }
        set {
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(newValue)
                set(encoded, forKey: Keys.favoritePokemons)
            } catch {
                print("Failed to encode favoritePokemons: \(error)")
            }
        }
    }
    
    func toggleFavorite(pokemon: PokemonData) {
        var favorites = favoritePokemons
        if let index = favorites.firstIndex(where: { $0.id == pokemon.id }) {
            favorites.remove(at: index)
            print("Removed \(pokemon.name) from favorites.")
        } else {
            favorites.append(pokemon)
            print("Added \(pokemon.name) to favorites.")
        }
        favoritePokemons = favorites
        print("Current favorites: \(favorites.map { $0.name })")
    }
    
    func isFavorite(pokemon: PokemonData) -> Bool {
        return favoritePokemons.contains(where: { $0.id == pokemon.id })
    }
}

import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel)
    func didFailWithError(error: Error)
}
struct PokemonManager {
    
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemon(id: Int) {
        performRequest(id: id)
    }
    
    func performRequest(id: Int) {
        // create url
        if let url = URL(string: "\(K.Network.baseUrl)/\(id)") {
            // create session
            let session = URLSession(configuration: .default)
            // give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                // error
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                // success
                if let safeData = data {
                    if let pokemon = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePokemon(self, pokemon: pokemon)
                    }
                }
            }
            // resume task
            task.resume()
        }
    }
    
    func parseJSON(_ pokemonData: Data) -> PokemonModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokemonData.self, from: pokemonData)
            let id = decodedData.id
            let name = decodedData.name
            let height = decodedData.height
            let weight = decodedData.weight
            let pokemon = PokemonModel(id: id, name: name, height: height, weight: weight)
            return pokemon
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

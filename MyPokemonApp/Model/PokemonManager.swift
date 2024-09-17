import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonData)
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData])
    func didFailWithError(error: Error)
}
struct PokemonManager {
    
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemon(id: Int) {
        performRequest(urlString: "\(K.Network.baseUrl)/\(id)", isSinglePokemon: true)
    }
    
    func fetchPokemonList() {
        performRequest(urlString: "\(K.Network.baseUrl)?limit=\(K.Network.limit)", isSinglePokemon: false)
    }
    
    private func performRequest(urlString: String, isSinglePokemon: Bool) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let safeData = data {
                    if isSinglePokemon {
                        if let pokemon = self.parseJSON(data: safeData, type: PokemonData.self) {
                            self.delegate?.didUpdatePokemon(self, pokemon: pokemon)
                        }
                    } else {
                        if let pokemonList = self.parseJSON(data: safeData, type: PokemonListData.self) {
                            let pokemonDataList = pokemonList.results.map { result -> PokemonData in
                                PokemonData(id: nil, name: result.name, height: nil, weight: nil)
                            }
                            self.delegate?.didUpdatePokemonList(self, pokemonList: pokemonDataList)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON<T: Decodable>(data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

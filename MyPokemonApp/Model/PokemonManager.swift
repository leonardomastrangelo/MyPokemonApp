import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData])
    func didFailWithError(error: Error)
}
struct PokemonManager {
    
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemonList(offset: Int) {
        performRequest(urlString: "\(Constants.Network.baseUrl)?limit=\(Constants.Network.limit)&offset=\(offset)")
    }
    
    func fetchPokemonByName(pokemonName: String, completion: @escaping (PokemonData?) -> Void) {
        let urlString = "\(Constants.Network.baseUrl)/\(pokemonName)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Failed to fetch details for \(pokemonName): \(error)")
                    completion(nil)
                    return
                }
                
                if let safeData = data {
                    if let pokemon = self.parseJSON(data: safeData, type: PokemonData.self) {
                        completion(pokemon)
                    } else {
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let safeData = data {
                    if let pokemonList = self.parseJSON(data: safeData, type: PokemonListData.self) {
                        let pokemonDataList = pokemonList.results.map { result -> PokemonData in
                            PokemonData(id: nil, name: result.name, height: nil, weight: nil)
                        }
                        self.delegate?.didUpdatePokemonList(self, pokemonList: pokemonDataList)
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

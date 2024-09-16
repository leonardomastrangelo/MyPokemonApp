import Foundation

protocol PokemonListManagerDelegate {
    func didUpdatePokemonList(_ pokemonListManager: PokemonListManager, pokemonList: PokemonListModel)
    func didFailWithError(error: Error)
}

struct PokemonListManager {
    var delegate: PokemonListManagerDelegate?
    
    func fetchPokemonList() {
        performRequest()
    }
    
    func performRequest() {
        // create url
        if let url = URL(string: K.Network.baseUrl) {
            // create url session
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
                    if let pokemonList = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePokemonList(self, pokemonList: pokemonList)
                    }
                }
            }
            // start the task
            task.resume()
        }
    }
    
    func parseJSON(_ pokemonListData: Data) -> PokemonListModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokemonListData.self, from: pokemonListData)
            let pokemonList = decodedData.results.map({ result in
                PokemonListItem(name: result.name)
            })
            return PokemonListModel(pokemonList: pokemonList)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

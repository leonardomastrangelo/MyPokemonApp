import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData])
    func didFailWithError(error: Error)
}

class PokemonManager {
    
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemonList(offset: Int) {
        let endpoint = PokemonAPI.getPokemonList(offset: offset, limit: Constants.Network.limit)
        NetworkManager.shared.performRequestWithRetry(endpoint: endpoint) { (result: Swift.Result<PokemonListData, NetworkError>) in
            switch result {
            case .success(let pokemonListData):
                let pokemonDataList = pokemonListData.results.map { result -> PokemonData in
                    PokemonData(id: nil, name: result.name, height: nil, weight: nil)
                }
                self.delegate?.didUpdatePokemonList(self, pokemonList: pokemonDataList)
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchPokemonByName(pokemonName: String, completion: @escaping (PokemonData?) -> Void) {
        let endpoint = PokemonAPI.getPokemonByName(name: pokemonName)
        NetworkManager.shared.performRequestWithRetry(endpoint: endpoint) { (result: Swift.Result<PokemonData, NetworkError>) in
            switch result {
            case .success(let pokemonData):
                completion(pokemonData)
            case .failure(let error):
                print("Failed to fetch details for \(pokemonName): \(error)")
                completion(nil)
            }
        }
    }
}



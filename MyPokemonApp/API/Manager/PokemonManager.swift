import UIKit

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
                    PokemonData(id: nil, name: result.name, height: nil, weight: nil, sprites: nil, types: nil)
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
    
    func fetchPokemonImage(from imageURL: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageURL) else {
            print("Invalid image URL")
            completion(nil)
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Error loading image: \(error)")
                completion(nil)
            }
        }
    }
    
}



import Foundation

struct PokemonList: Codable {
    let results: [Result]
}

struct Result: Codable {
    let name: String
}

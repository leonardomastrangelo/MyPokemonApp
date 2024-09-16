import Foundation

struct PokemonListData: Codable {
    let results: [Result]
}

struct Result: Codable {
    let name: String
}

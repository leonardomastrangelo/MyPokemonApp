import Foundation

struct PokemonData: Codable {
    let id: Int?
    let name: String
    let height: Int?
    let weight: Int?
    let sprites: Sprites?
    let types: [Slot]?
    
    var formattedId: String? {
        return "#\(String(format: "%03d", id ?? 0))"
    }
    
    var capitalizedName: String {
        return name.capitalized
    }
}

struct Sprites: Codable {
    let front_default: String
    let back_default: String
}

struct Slot: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
    
    var capitalizedTypeName: String {
        return name.capitalized
    }
}


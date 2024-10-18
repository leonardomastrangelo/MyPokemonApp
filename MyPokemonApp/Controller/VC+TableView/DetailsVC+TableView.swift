import UIKit

enum DetailsSectionType: Int, CaseIterable {
    case header = 0;
    case card = 1;
    case body = 2
}

//MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailsSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case DetailsSectionType.header.rawValue:
            return 1
        case DetailsSectionType.card.rawValue:
            return 1
        case DetailsSectionType.body.rawValue:
            return infoItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemon = pokemon else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case DetailsSectionType.header.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.PokemonItemCellIdentifier, for: indexPath) as? PokemonItemCell {
                
                let isFavorite = UserDefaults.standard.isFavorite(pokemon: pokemon)
                cell.configure(text: pokemon.name, isFavorite: isFavorite)
                
                cell.toggleFavoriteCallback = { [weak self] in
                    self?.toggleFavorite(for: pokemon)
                }
                
                return cell
            }
        case DetailsSectionType.card.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.PokemonOverlayImageCellIdentifier, for: indexPath) as? PokemonOverlayImageCell {
                let backgroundImage = UIImage(named: Constants.Images.arenaBackground)
                if let overlayImageURLString = pokemon.sprites?.front_default {
                    cell.configure(backgroundImage: backgroundImage, overlayImageURL: overlayImageURLString)
                }
                
                return cell
            }
        case DetailsSectionType.body.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.PokemonInfoCellIdentifier, for: indexPath) as? PokemonInfoCell {
                
                let item = infoItems[indexPath.row]
                
                cell.configure(titleText: item.title, detailText: item.detail)
                cell.isUserInteractionEnabled = false
                
                return cell
            }
            
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
}

//MARK: - UITableViewDelegate
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


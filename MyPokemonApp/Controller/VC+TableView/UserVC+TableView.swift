import UIKit

enum UserSectionType: Int, CaseIterable {
    case header = 0
    case card = 1
    case body = 2
    case preferences = 3
}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UserSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case UserSectionType.header.rawValue:
            return 1
        case UserSectionType.card.rawValue:
            return 1
        case UserSectionType.body.rawValue:
            return trainerInfo.count
        case UserSectionType.preferences.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case UserSectionType.header.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerTitleCellIdentifier, for: indexPath) as? TrainerTitleCell {
                cell.configure(title: "Trainer HUB")
                return cell
            }
        case UserSectionType.card.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerImageCellIdentifier, for: indexPath) as? TrainerImageCell {
                return cell
            }
        case UserSectionType.body.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerInfoCellIdentifier, for: indexPath) as? TrainerInfoCell {
                let info = trainerInfo[indexPath.row]
                cell.configure(titleText: info.title)
                cell.customTitleLabel.text = info.detail
                return cell
            }
        case UserSectionType.preferences.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.HorizontalCollectionViewCellIdentifier, for: indexPath) as? HorizontalCollectionViewCell {
                cell.favoritePokemons = favoritePokemons
                cell.collectionView.reloadData()
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

import UIKit

enum UserSectionType: Int, CaseIterable {
    case header = 0
    case card = 1
    case body = 2
    case preferences = 3
}

enum InfoCellType: Int {
    case generalInfo
    case date
    case phoneNumber
    
    static func cellType(for row: Int) -> InfoCellType {
        switch row {
        case 0, 2:
            return .generalInfo
        case 1:
            return .date
        case 3:
            return .phoneNumber
        default:
            return .generalInfo
        }
    }
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
        switch UserSectionType(rawValue: indexPath.section) {
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerTitleCellIdentifier, for: indexPath) as? TrainerTitleCell {
                cell.configure(title: "Trainer HUB")
                return cell
            }
            
        case .card:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerImageCellIdentifier, for: indexPath) as? TrainerImageCell {
                return cell
            }
            
        case .body:
            let cellType = InfoCellType.cellType(for: indexPath.row)
            let info = trainerInfo[indexPath.row]
            
            switch cellType {
            case .generalInfo:
                if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerInfoCellIdentifier, for: indexPath) as? TrainerInfoCell {
                    cell.configure(placeholder: info.title.translated(), accountKey: info.accountKey)
                    return cell
                }
            case .date:
                if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.DatePickerCellIdentifier, for: indexPath) as? DatePickerCell {
                    cell.configure(accountKey: info.accountKey)
                    return cell
                }
            case .phoneNumber:
                if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.PhoneNumberCellIdentifier, for: indexPath) as? PhoneNumberCell {
                    cell.configure(placeholder: info.title.translated(), accountKey: info.accountKey)
                    return cell
                }
            }
            
        case .preferences:
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

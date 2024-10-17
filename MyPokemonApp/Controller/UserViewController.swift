import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoritePokemons: [PokemonData] = []
    let trainerInfo: [(title: String, detail: String)] = [
        ("Name", "Leo Mastrangelo"),
        ("BirthDay", "01/07/2002"),
        ("HomeTown", "Lavandonia")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.TBView.TrainerTitleCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.TrainerTitleCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.TrainerImageCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.TrainerImageCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.TrainerInfoCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.TrainerInfoCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.HorizontalCollectionViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.HorizontalCollectionViewCellIdentifier)
        
        favoritePokemons = UserDefaults.standard.favoritePokemons
        
        addTableViewDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        applyTheme(isDarkMode: UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey))
        favoritePokemons = UserDefaults.standard.favoritePokemons
        tableView.reloadData()
    }
    
    private func applyTheme(isDarkMode: Bool) {
        let backgroundColor: UIColor = isDarkMode ? UIColor.black.withAlphaComponent(0.7) : UIColor.systemYellow.withAlphaComponent(0.7)
        let separatorColor: UIColor = isDarkMode ? UIColor.white : UIColor.black
        
        tableView.backgroundColor = backgroundColor
        tableView.separatorColor = separatorColor
    }
    
    private func addTableViewDetails() {
        tableView.layer.cornerRadius = Constants.Sizes.pokeCornerRadius
        tableView.layer.borderWidth = Constants.Sizes.pokeBorderWidth
        tableView.layer.borderColor = Constants.PokeColors.pokeGray
    }
}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return trainerInfo.count
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerTitleCellIdentifier, for: indexPath) as? TrainerTitleCell {
                cell.configure(title: "Trainer HUB")
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerImageCellIdentifier, for: indexPath) as? TrainerImageCell {
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.TrainerInfoCellIdentifier, for: indexPath) as? TrainerInfoCell {
                let info = trainerInfo[indexPath.row]
                cell.configure(titleText: info.title)
                cell.customTitleLabel.text = info.detail
                return cell
            }
        case 3:
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

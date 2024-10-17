import UIKit

class DetailsViewController: UIViewController {
    
    var pokemon: PokemonData?
    var pokemonManager = PokemonManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailsBackgroundImage: UIImageView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pokemon != nil {
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: Constants.TBView.PokemonItemCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.PokemonItemCellIdentifier)
            tableView.register(UINib(nibName: Constants.TBView.PokemonOverlayImageCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.PokemonOverlayImageCellIdentifier)
            tableView.register(UINib(nibName: Constants.TBView.PokemonInfoCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.PokemonInfoCellIdentifier)
            
            tableView.reloadData()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        styleTableView()
        tableView.reloadData()
    }
}

extension DetailsViewController {
    func toggleFavorite(for pokemon: PokemonData) {
        print("Toggling favorite for \(pokemon.name)")
        UserDefaults.standard.toggleFavorite(pokemon: pokemon)
        
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}

//MARK: - Theme And Table View Style
extension DetailsViewController {
    private func applyTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        if isDarkMode {
            detailsBackgroundImage.image = UIImage(named: Constants.Images.darkDetailsBackground)
        } else {
            detailsBackgroundImage.image = UIImage(named: Constants.Images.lightDetailsBackground)
        }
    }
    
    private func styleTableView() {
        tableView.layer.cornerRadius = Constants.Sizes.pokeCornerRadius
    }
}

//MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemon = pokemon else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.PokemonItemCellIdentifier, for: indexPath) as? PokemonItemCell {
                
                let isFavorite = UserDefaults.standard.isFavorite(pokemon: pokemon)
                cell.configure(text: pokemon.name, isFavorite: isFavorite)
                
                cell.toggleFavoriteCallback = { [weak self] in
                    self?.toggleFavorite(for: pokemon)
                }
                
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.PokemonOverlayImageCellIdentifier, for: indexPath) as? PokemonOverlayImageCell {
                if let backgroundImage = UIImage(named: Constants.Images.arenaBackground) {
                    if let overlayImageURLString = pokemon.sprites?.front_default {
                        cell.configure(backgroundImage: backgroundImage, overlayImageURL: overlayImageURLString)
                    }
                }
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.PokemonInfoCellIdentifier, for: indexPath) as? PokemonInfoCell {
                
                let infoItems: [(title: String, detail: String)] = [
                    ("Pokédex_Number".translated(), pokemon.formattedId ?? ""),
                    ("Name".translated(), pokemon.capitalizedName),
                    ("Height".translated(), "\(pokemon.height ?? 0)m"),
                    ("Weight".translated(), "\(pokemon.weight ?? 0)Kg"),
                    ("Type".translated(), pokemon.types?.map { $0.type.capitalizedTypeName }.joined(separator: ", ") ?? "None")
                ]
                
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


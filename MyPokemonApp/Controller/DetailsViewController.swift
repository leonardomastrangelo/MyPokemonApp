import UIKit

class DetailsViewController: UIViewController {
    
    var pokemon: PokemonData?
    var pokemonManager = PokemonManager()
    
    var infoItems: [(title: String, detail: String)] {
        guard let pokemon = pokemon else { return [] }
        
        return [
            ("Pokédex_Number".translated(), pokemon.formattedId ?? ""),
            ("Name".translated(), pokemon.capitalizedName),
            ("Height".translated(), "\(pokemon.height ?? 0)m"),
            ("Weight".translated(), "\(pokemon.weight ?? 0)Kg"),
            ("Type".translated(), pokemon.types?.map { $0.type.capitalizedTypeName }.joined(separator: ", ") ?? "None")
        ]
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailsBackgroundImage: UIImageView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSettingsButton()
        
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

//MARK: - Actions
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


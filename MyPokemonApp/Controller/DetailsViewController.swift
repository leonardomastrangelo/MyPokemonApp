import UIKit

class DetailsViewController: UIViewController {
    
    var pokemon: PokemonData?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailsBackgroundImage: UIImageView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pokemon != nil {
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: Constants.TBView.SectionZeroCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.SectionZeroCellIdentifier)
            tableView.register(UINib(nibName: Constants.TBView.SectionOneCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.SectionOneCellIdentifier)
            tableView.register(UINib(nibName: Constants.TBView.SectionTwoCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.SectionTwoCellIdentifier)
            
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
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.SectionZeroCellIdentifier, for: indexPath) as! SectionZeroCell
            cell.configure(text: pokemon.name)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.SectionOneCellIdentifier, for: indexPath) as! SectionOneCell
            let backgroundImage = UIImage(named: Constants.Images.arenaBackground)!
            if let overlayImageURL = URL(string: pokemon.sprites?.front_default ?? "") {
                cell.configure(backgroundImage: backgroundImage, overlayImageURL: overlayImageURL)
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.SectionTwoCellIdentifier, for: indexPath) as! SectionTwoCell
            
            switch indexPath.row {
            case 0:
                cell.configure(titleText: "Pokédex_Number".translated(), detailText: "#\(String(format: "%03d", pokemon.id ?? 0))")
            case 1:
                cell.configure(titleText: "Name".translated(), detailText: pokemon.name)
                
            case 2:
                cell.configure(titleText: "Height".translated(), detailText: "\(pokemon.height ?? 0)m")
            case 3:
                cell.configure(titleText: "Weight".translated(), detailText: "\(pokemon.weight ?? 0)Kg")
            case 4:
                if let types = pokemon.types {
                    let typeNames = types.map { $0.type.name }.joined(separator: ", ")
                    cell.configure(titleText: "Type".translated(), detailText: typeNames)
                } else {
                    cell.configure(titleText: "Type".translated(), detailText: "None")
                }
            default:
                break
            }
            
            cell.isUserInteractionEnabled = false
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


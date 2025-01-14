import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoritePokemons: [PokemonData] = []
    var trainerInfo: [(title: String, accountKey: String)] = [
        ("Name", "nameKey"),
        ("BirthDay", "birthdayKey"),
        ("HomeTown", "hometownKey"),
        ("PhoneNumber", "phonenumberKey")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSettingsButton()
        
        setupUI()
        
        favoritePokemons = UserDefaults.standard.favoritePokemons
        
        addTableViewDetails()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        applyTheme(isDarkMode: UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey))
        changeLanguage()
        favoritePokemons = UserDefaults.standard.favoritePokemons
        loadTrainerInfo()
        tableView.reloadData()
    }
    
    private func setupUI() {
        tableView.allowsSelection = false
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.TBView.TrainerTitleCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.TrainerTitleCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.TrainerImageCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.TrainerImageCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.TrainerInfoCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.TrainerInfoCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.DatePickerCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.DatePickerCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.PhoneNumberCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.PhoneNumberCellIdentifier)
        tableView.register(UINib(nibName: Constants.TBView.HorizontalCollectionViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.HorizontalCollectionViewCellIdentifier)
    }
    
    private func loadTrainerInfo() {
        for (index, info) in trainerInfo.enumerated() {
            KeychainManager.loadData(service: Constants.Keychain.serviceName, account: info.accountKey) { result in
                switch result {
                case .success(let value):
                    print("Loaded data for \(info.accountKey): \(value)")
                    if let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: UserSectionType.body.rawValue)) as? TrainerInfoCell {
                        cell.customTextField.text = value
                    }
                case .failure(let error):
                    print("Error loading data: \(error.localizedDescription)")
                }
            }
        }
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
    
    func changeLanguage() {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: UserSectionType.preferences.rawValue)) as? HorizontalCollectionViewCell {
            cell.updateTitleAndTheme()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

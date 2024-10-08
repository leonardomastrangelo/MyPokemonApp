import UIKit

class DetailsViewController: UIViewController {
    
    var pokemon: PokemonData?
    
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var numberLabelText: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var detailsStackView: UIStackView!
    
    @IBOutlet weak var nameLabelText: UILabel!
    @IBOutlet weak var nameLabelPokemon: UILabel!
    
    @IBOutlet weak var typeLabelText: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var heightLabelText: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabelText: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pokemon = pokemon {
            applyStyle()
            updateUI(with: pokemon)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let pokemon = pokemon {
            updateUI(with: pokemon)
        }
    }
    
    private func updateUI(with pokemon: PokemonData) {
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name.translated().uppercased()
            
            self.numberLabelText.text = "Pokédex Number".translated()
            self.numberLabel.text = "#\(String(format: "%03d", pokemon.id ?? 0))"
            
            self.nameLabelText.text = "Name".translated()
            self.nameLabelPokemon.text = pokemon.name.uppercased()
            
            self.typeLabelText.text = "Type".translated()
            if let types = pokemon.types, !types.isEmpty {
                self.typeLabel.text = types.map { $0.type.name }.joined(separator: ", ")
            } else {
                self.typeLabel.text = "None"
            }
            
            self.heightLabelText.text = "Height".translated()
            self.heightLabel.text = "\(pokemon.height ?? 0)m"
            
            self.weightLabelText.text = "Weight".translated()
            self.weightLabel.text = "\(pokemon.weight ?? 0)Kg"
            
            if let imageUrlString = pokemon.sprites?.front_default, let imageUrl = URL(string: imageUrlString) {
                self.loadImage(from: imageUrl)
            }
        }
    }
    
    private func applyStyle() {
        applyFont()
        applyNameStackViewLayerRules()
        applyDetailsStackViewLayerRules()
        
    }
    
    private func applyNameStackViewLayerRules() {
        self.nameStackView.layer.cornerRadius = 10
        self.nameStackView.backgroundColor = UIColor.systemYellow
        self.nameStackView.isLayoutMarginsRelativeArrangement = true
        self.nameStackView.layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        self.nameStackView.layer.borderWidth = 3
        self.nameStackView.layer.borderColor = CGColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    private func applyDetailsStackViewLayerRules() {
        self.detailsStackView.layer.cornerRadius = 10
        self.detailsStackView.backgroundColor = UIColor.systemGreen
        self.detailsStackView.isLayoutMarginsRelativeArrangement = true
        self.detailsStackView.layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        self.detailsStackView.layer.borderWidth = 3
        self.detailsStackView.layer.borderColor = CGColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    private func applyFont() {
        self.nameLabel.font = UIFont.customFont(ofSize: 30)

        self.numberLabelText.font = UIFont.customFont(ofSize: 22)
        self.numberLabel.font = UIFont.customFont(ofSize: 19)
        
        self.nameLabelText.font = UIFont.customFont(ofSize: 22)
        self.nameLabelPokemon.font = UIFont.customFont(ofSize: 19)
        
        self.typeLabelText.font = UIFont.customFont(ofSize: 22)
        self.typeLabel.font = UIFont.customFont(ofSize: 19)
        
        self.heightLabelText.font = UIFont.customFont(ofSize: 22)
        self.heightLabel.font = UIFont.customFont(ofSize: 19)
        
        self.weightLabelText.font = UIFont.customFont(ofSize: 22)
        self.weightLabel.font = UIFont.customFont(ofSize: 19)
    }
    
    private func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error during image loading: \(error)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
        task.resume()
    }
}


//MARK: - PokemonManagerDelegate
extension DetailsViewController: PokemonManagerDelegate {
    
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData]) {}
    
    func didFailWithError(error: Error) {
        print("Failed to fetch Pokemon details: \(error)")
    }
}


import UIKit

class HorizontalCollectionViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var favoritePokemons: [PokemonData] = [] {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        updateTitleAndTheme()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 200)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: Constants.TBView.PokemonCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.TBView.PokemonCollectionViewCellIdentifier)
    }
    
    private func updateUI() {
        if favoritePokemons.isEmpty {
            collectionView.isHidden = true
        } else {
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
    
    func updateTitleAndTheme() {
        titleLabel.text = "My_Favorite_Pokemon".translated()
        titleLabel.font = UIFont.customFont(ofSize: Constants.FontSizes.f22)
        
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        titleLabel.textColor = isDarkMode ? UIColor.white : UIColor.black
    }
    
}

// MARK: - UICollectionViewDataSource
extension HorizontalCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.TBView.PokemonCollectionViewCellIdentifier, for: indexPath) as? PokemonCollectionViewCell {
            let pokemon = favoritePokemons[indexPath.item]
            cell.configure(with: pokemon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalCollectionViewCell: UICollectionViewDelegate {
    
}

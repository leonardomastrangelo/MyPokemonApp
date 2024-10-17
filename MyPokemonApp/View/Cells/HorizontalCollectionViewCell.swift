import UIKit

class HorizontalCollectionViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var favoritePokemons: [PokemonData] = [] {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 250)
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
}

// MARK: - UICollectionViewDataSource
extension HorizontalCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.TBView.PokemonCollectionViewCellIdentifier, for: indexPath) as! PokemonCollectionViewCell
        let pokemon = favoritePokemons[indexPath.item]
        cell.configure(with: pokemon)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalCollectionViewCell: UICollectionViewDelegate {
    
}

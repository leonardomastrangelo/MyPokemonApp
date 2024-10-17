//
//  PokemonCell.swift
//  MyPokemonApp
//
//  Created by Leonardo Mastrangelo on 16/09/24.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokeball: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var isFavoriteIcon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.customFont(ofSize: 20)
        labelName.font = UIFont.customFont(ofSize: 20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with pokemon: PokemonData) {
        label.text = pokemon.formattedId
        labelName.text = pokemon.name.uppercased()
        
        backgroundColor = UIColor.clear
        
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        updateCellColors(isDarkMode: isDarkMode)
        
        updateFavoriteIcon(for: pokemon)
    }
    
    private func updateCellColors(isDarkMode: Bool) {
        label.textColor = isDarkMode ? .white : .black
        labelName.textColor = isDarkMode ? .white : .black
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = isDarkMode ? UIColor.black : UIColor.systemYellow
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    private func updateFavoriteIcon(for pokemon: PokemonData) {
        let isFavorite = UserDefaults.standard.isFavorite(pokemon: pokemon)
        let starImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        isFavoriteIcon.setImage(starImage, for: .normal)
    }
    
}

import UIKit

struct Constants {
    static let appTitle = "PokemonApp"
    
    struct LocalizedStrings {
        static let localizedUserDefaultKey = "LocalizedUserDefaultKey"
        static var localizedDefaultLanguage = "en"
    }
    
    struct UserDefaults {
        static let darkModeKey = "darkModeEnabled"
        static let selectedLanguageKey = "selectedLanguage"
    }
    
    struct Keychain {
        static let serviceName = "com.leomastrangelo.PokemonApp"
    }
    
    struct SupportedLanguages {
        static let english = "en"
        static let italian = "it"
    }
    
    struct Network {
        static let limit = 20
        static let maxRetryAttempts = 3
        static let timeOutInterval = 30.0
        static let scheme = "https"
        static let host = "pokeapi.co"
    }
    
    struct TBView {
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "PokemonCell"
        static let homeToDetail = "HomeToDetail"
        
        static let PokemonItemCellNibName = "PokemonItemCell"
        static let PokemonItemCellIdentifier = "PokemonItemCellIdentifier"
        
        static let PokemonOverlayImageCellNibName = "PokemonOverlayImageCell"
        static let PokemonOverlayImageCellIdentifier = "PokemonOverlayImageCellIdentifier"
        
        static let PokemonInfoCellNibName = "PokemonInfoCell"
        static let PokemonInfoCellIdentifier = "PokemonInfoCellIdentifier"
        
        static let TrainerTitleCellNibName = "TrainerTitleCell"
        static let TrainerTitleCellIdentifier = "TrainerTitleCellIdentifier"
        
        static let TrainerImageCellNibName = "TrainerImageCell"
        static let TrainerImageCellIdentifier = "TrainerImageCellIdentifier"
        
        static let TrainerInfoCellNibName = "TrainerInfoCell"
        static let TrainerInfoCellIdentifier = "TrainerInfoCellIdentifier"
        
        static let DatePickerCellNibName = "DatePickerCell"
        static let DatePickerCellIdentifier = "DatePickerCellIdentifier"
        
        static let PhoneNumberCellNibName = "PhoneNumberCell"
        static let PhoneNumberCellIdentifier = "PhoneNumberCellIdentifier"
        
        static let HorizontalCollectionViewCellNibName = "HorizontalCollectionViewCell"
        static let HorizontalCollectionViewCellIdentifier = "HorizontalCollectionViewCellIdentifier"
        
        static let PokemonCollectionViewCellNibName = "PokemonCollectionViewCell"
        static let PokemonCollectionViewCellIdentifier = "PokemonCollectionViewCellIdentifier"
        
        static let languageCellIdentifier = "LanguageCellIdentifier"
        static let darkModeCellIdentifier = "DarkModeCellIdentifier"
    }
    
    struct Sizes {
        static let pokeCornerRadius = 10.0
        static let pokeBorderWidth = 3.0
        static let pokeLayoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
    
    struct FontSizes {
        static let f40 = 40.0
        static let f30 = 30.0
        static let f22 = 22.0
        static let f19 = 19.0
        static let f15 = 15.0
    }
    
    struct PokeColors {
        static let pokeGray = CGColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    struct Images {
        static let darkDetailsBackground = "DarkDetailsBackground"
        static let lightDetailsBackground = "LightDetailsBackground"
        
        static let darkSettingsBackground = "SettingsDark"
        static let lightSettingsBackground = "SettingsLight"
        
        static let arenaBackground = "Arena"
    }
    
}



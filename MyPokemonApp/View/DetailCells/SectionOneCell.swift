import UIKit

class SectionOneCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overlayImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(backgroundImage: UIImage, overlayImageURL: URL) {
        backgroundImageView.image = backgroundImage
        URLSession.shared.dataTask(with: overlayImageURL) { (data, response, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data for image")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.overlayImageView.image = image
                }
            } else {
                print("Unable to create image from data")
            }
        }.resume()
    }
    
    
}

//
//  ApodTableViewCell.swift
//  APOD
//
//  Created by Juan Diego Marin on 28/10/22.
//

import UIKit

class ApodTableViewCell: UITableViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var planet: PlaneratyInformation? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup() {
    
        nameLabel.text = planet?.copyright
        descriptionLabel.text = planet?.explanation
        if let url = planet?.url {
            planetImage.downloaded(from: url, placeHolder: nil)
             if let url2 = planet?.hdurl {
                 planetImage.downloaded(from: url2, placeHolder: nil)
             }
        }
    }

}

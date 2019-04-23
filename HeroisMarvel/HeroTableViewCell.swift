//
//  HeroTableViewCell.swift
//  HeroisMarvel
//
//  Created by Humberto Rayashi on 23/04/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivThumb.layer.cornerRadius = ivThumb.frame.width / 2
        ivThumb.layer.borderColor = UIColor.white.cgColor
        ivThumb.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepare(with hero: Hero) {
        lbName.text = hero.name
        lbDescription.text = hero.description
        
        if let url = URL(string: hero.thumbnail.url) {
            ivThumb.kf.setImage(with: url)
        } else {
            ivThumb.image = nil
        }
    }
}

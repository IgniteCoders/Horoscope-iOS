//
//  HoroscopeViewCell.swift
//  Horoscope-iOS
//
//  Created by Mañanas on 8/4/24.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var signImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: Data
    
    func render(horoscope: Horoscope) {
        titleLabel.text = horoscope.name
        subtitleLabel.text = horoscope.dates
        signImageView.image = horoscope.image
        
        let favoriteHoroscope = UserDefaults.standard.string(forKey: "FAVORITE_HOROSCOPE") ?? ""
        let isFavorite = horoscope.id == favoriteHoroscope
        
        favoriteButton.isHidden = !isFavorite
    }
}

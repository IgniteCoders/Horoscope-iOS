//
//  HoroscopeViewCell.swift
//  Horoscope-iOS
//
//  Created by Mañanas on 8/4/24.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var signImageView: UIImageView!
    
    func render(horoscope: Horoscope) {
        titleLabel.text = horoscope.name
        subtitleLabel.text = horoscope.dates
        signImageView.image = horoscope.image
    }
}

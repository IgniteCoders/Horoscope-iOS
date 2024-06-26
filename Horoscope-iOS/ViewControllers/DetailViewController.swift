//
//  DetailViewController.swift
//  Horoscope-iOS
//
//  Created by Mañanas on 9/4/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    
    var horoscope: Horoscope? = nil
    var horoscopeIndex:Int = -1
    var isFavorite: Bool = false
    
    // MARK: Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var favoriteButtomItem: UIBarButtonItem!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    // MARK: Actions
    
    @IBAction func setFavorite(_ sender: UIBarButtonItem) {
        isFavorite = !isFavorite
        if (isFavorite) {
            UserDefaults.standard.setValue(horoscope?.id, forKey: "FAVORITE_HOROSCOPE")
        } else {
            UserDefaults.standard.setValue("", forKey: "FAVORITE_HOROSCOPE")
        }
        setFavoriteButtomItem()
    }
    
    @IBAction func goToPrev(_ sender: UIButton) {
        if (horoscopeIndex == 0) {
            horoscopeIndex = HoroscopeProvider.getHoroscopes().count
        }
        horoscopeIndex -= 1
        horoscope = HoroscopeProvider.getHoroscopes()[horoscopeIndex]
        loadData()
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        horoscopeIndex += 1
        if (horoscopeIndex == HoroscopeProvider.getHoroscopes().count) {
            horoscopeIndex = 0
        }
        horoscope = HoroscopeProvider.getHoroscopes()[horoscopeIndex]
        loadData()
    }
    
    // MARK: Data
    
    func loadData() {
        let favoriteHoroscope = UserDefaults.standard.string(forKey: "FAVORITE_HOROSCOPE") ?? ""
        isFavorite = horoscope?.id == favoriteHoroscope
        
        setFavoriteButtomItem()
        
        
        self.navigationItem.title = horoscope?.name
        nameLabel.text = horoscope?.name
        signImageView.image = horoscope?.image
        
        getHoroscopeLuck()
    }
    
    func setFavoriteButtomItem() {
        if (isFavorite) {
            favoriteButtomItem.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButtomItem.image = UIImage(systemName: "heart")
        }
    }
    
    func getHoroscopeLuck() {
        Task {
            do {
                let luck = try await HoroscopeProvider.getHoroscopeLuck(horoscopeId: horoscope!.id)
                
                descriptionTextView.text = luck
            } catch {
                print(error)
            }
        }
    }

}

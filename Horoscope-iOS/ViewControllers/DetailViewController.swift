//
//  DetailViewController.swift
//  Horoscope-iOS
//
//  Created by Mañanas on 9/4/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var horoscope: Horoscope? = nil
    var isFavorite: Bool = false

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var favoriteButtomItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let favoriteHoroscope = UserDefaults.standard.string(forKey: "FAVORITE_HOROSCOPE") ?? ""
        isFavorite = horoscope?.id == favoriteHoroscope
        
        setFavoriteButtomItem()
        
        
        self.navigationItem.title = horoscope?.name
        nameLabel.text = horoscope?.name
        signImageView.image = horoscope?.image
        
        getHoroscopeLuck()
    }
    
    @IBAction func setFavorite(_ sender: UIBarButtonItem) {
        isFavorite = !isFavorite
        if (isFavorite) {
            UserDefaults.standard.setValue(horoscope?.id, forKey: "FAVORITE_HOROSCOPE")
        } else {
            UserDefaults.standard.setValue("", forKey: "FAVORITE_HOROSCOPE")
        }
        setFavoriteButtomItem()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

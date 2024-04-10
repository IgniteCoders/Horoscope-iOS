//
//  HoroscopeProvider.swift
//  Horoscope-iOS
//
//  Created by Mañanas on 9/4/24.
//

import Foundation
import UIKit

class HoroscopeProvider {
    
    // MARK: Data Providers
    
    static func getHoroscopes() -> [Horoscope] {
        let list: [Horoscope] = [
            Horoscope(id: "aries", name: "Aries", image: UIImage(named: "horoscope-icons/aries")!, dates: "March 21 to April 19"),
            Horoscope(id: "taurus", name: "Taurus", image: UIImage(named: "horoscope-icons/taurus")!, dates: "April 20 to May 20"),
            Horoscope(id: "gemini", name: "Gemini", image: UIImage(named: "horoscope-icons/gemini")!, dates: "May 21 to June 20"),
            Horoscope(id: "cancer", name: "Cancer", image: UIImage(named: "horoscope-icons/cancer")!, dates: "June 21 to July 22"),
            Horoscope(id: "leo", name: "Leo", image: UIImage(named: "horoscope-icons/leo")!, dates: "July 23 to August 22"),
            Horoscope(id: "virgo", name: "Virgo", image: UIImage(named: "horoscope-icons/virgo")!, dates: "August 23 to September 22"),
            Horoscope(id: "libra", name: "Libra", image: UIImage(named: "horoscope-icons/libra")!, dates: "September 23 to October 22"),
            Horoscope(id: "scorpio", name: "Scorpio", image: UIImage(named: "horoscope-icons/scorpio")!, dates: "October 23 to November 21"),
            Horoscope(id: "sagittarius", name: "Sagittarius", image: UIImage(named: "horoscope-icons/sagittarius")!, dates: "November 22 to December 21"),
            Horoscope(id: "capricorn", name: "Capricorn", image: UIImage(named: "horoscope-icons/capricorn")!, dates: "December 22 to January 19"),
            Horoscope(id: "aquarius", name: "Aquarius", image: UIImage(named: "horoscope-icons/aquarius")!, dates: "January 20 to February 18"),
            Horoscope(id: "pisces", name: "Pisces", image: UIImage(named: "horoscope-icons/pisces")!, dates: "February 19 to March 20")
        ]
        return list
    }
    
    static func getHoroscope(id: String) -> Horoscope {
        return getHoroscopes().filter { $0.id == id }.first!
    }
    
    // MARK: API Network calls
    
    static func getHoroscopeLuck(horoscopeId: String) async throws -> String {
        var result: String
        let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=\(horoscopeId)&day=TODAY")
        
        guard let url = url else {
            throw RuntimeError("No url provided")
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw RuntimeError("JSON parse exception")
        }
        
        let jsonData = json["data"] as? [String: String]
        
        result = jsonData?["horoscope_data"] ?? ""
        
        return result
    }
    
    // MARK: Utils
    
    struct RuntimeError: Error {
        let description: String

        init(_ description: String) {
            self.description = description
        }
    }
}

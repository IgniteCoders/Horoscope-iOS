//
//  ViewController.swift
//  Horoscope-iOS
//
//  Created by Mañanas on 3/4/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    var list: [Horoscope] = HoroscopeProvider.getHoroscopes()
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: TableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.row]
        
        let cell: HoroscopeViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoroscopeViewCell
        
        cell.render(horoscope: item)
        //cell.titleLabel.text = item.name
        //cell.subtitleLabel.text = item.dates
        //cell.signImageView.image = item.image
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(list[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: Segues & Navigation
    
    /*@IBSegueAction func navigateToDetail(_ coder: NSCoder) -> DetailViewController? {
        
        let viewController = DetailViewController(coder: coder)
        viewController?.horoscope = list.first
        return viewController
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            print("No horoscope selected")
            return
        }
        
        let horoscope = list[indexPath.row]
        
        let viewController: DetailViewController = segue.destination as! DetailViewController
        
        viewController.horoscope = horoscope
        viewController.horoscopeIndex = indexPath.row
    }
}


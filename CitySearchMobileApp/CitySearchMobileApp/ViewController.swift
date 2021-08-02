//
//  ViewController.swift
//  CitySearchMobileApp
//
//  Created by Abhinav Mandloi on 01/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableview_City: UITableView!
    @IBOutlet weak var searchBar_City: UISearchBar!
    @IBOutlet weak var button_Search: UIButton!
    
    // MARK:- Constants
    private static let CELL_IDENTIFIER = "cell"
    
    private var cities: [City]? = nil
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setComponetsUI()
    }
    
    private func setComponetsUI() {
        self.button_Search.layer.borderColor = UIColor.link.cgColor
        self.button_Search.layer.borderWidth = 2
        self.button_Search.layer.cornerRadius = 10
        self.button_Search.clipsToBounds = true
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        self.searchCity()
    }
    
    private func searchCity() {
        if let citySearchText = self.searchBar_City.text {
            
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                
                let citySerachService: CitySearchResource = CitySearchResource()
                
                citySerachService.serachCities(with: citySearchText, maxRow: 10, userName: "keep_truckin") { (citySearchResponse) in
                    
                    if(citySearchResponse?.Cities != nil)
                    {
                        self.cities = citySearchResponse?.Cities
                        
                        DispatchQueue.main.async {
                            self.tableview_City.reloadData()
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            let ac = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        }
                    }
                }
            })
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell = tableView.dequeueReusableCell(withIdentifier: ViewController.CELL_IDENTIFIER) as! CityTableViewCell
        if let city = self.cities?[indexPath.row] {
            cityCell.cityDetails = city
        }
        return cityCell
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchCity()
    }
}


//
//  PlanetsTableViewController.swift
//  UnderdogDevs
//
//  Created by Fernando Olivares on 12/15/20.
//

import UIKit

class PlanetsTableViewController : UITableViewController {
    
    var planets: [Planet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkController = NetworkController()
        
        // In the app bundle, we want to go out to the network.
        let networkSession = NetworkSession(baseURL: "https://swapi.dev/api")
        networkController.fetchPlanets(using: networkSession) { result in
            
            switch result {
            
            case .failure:
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: NSLocalizedString("Impossible...", comment: ""),
                                                            message: NSLocalizedString("Perhaps the archives are incomplete", comment: ""),
                                                            preferredStyle: .alert)
                    alertController.addAction(.init(title: NSLocalizedString("OK", comment: ""),
                                                    style: .cancel,
                                                    handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            case .success(let planets):
                DispatchQueue.main.async {
                    self.planets = planets
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        
        cell.textLabel?.text = planets[indexPath.row].name
        
        return cell
    }
    
}

//
//  PlacesListTableViewController.swift
//  PlacesBelgrade
//
//  Created by Natasa Javorina on 8/7/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit

class PlacesListTableViewController: UITableViewController {
    
    var dataSource = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(placesModelDidUpdate), name: NSNotification.Name("PlacesUpdateDidFinishNotification"), object: nil)
        
        fetchPlacesFromDatabase()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func placesModelDidUpdate() {
        fetchPlacesFromDatabase()
    }
    
    func fetchPlacesFromDatabase() {
        if let results = CoreDataManager.shared.fetchPlaces() {
            dataSource = results
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCellIdentifier", for: indexPath)
        
        
        let place = dataSource[indexPath.row]
        cell.textLabel?.text = place.name
        cell.imageView?.downloadImage(imageUrl: place.placeImgUrl!, completion: {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        })
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlaceDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaceDetailSegue" {
            let place = dataSource[tableView.indexPathForSelectedRow!.row]
            (segue.destination as! PlaceViewController).place = place
        }
    }
    
}

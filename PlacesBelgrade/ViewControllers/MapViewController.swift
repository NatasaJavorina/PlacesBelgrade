//
//  MapViewController.swift
//  PlacesBelgrade
//
//  Created by Natasa Javorina on 8/7/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit
import MapKit

//cao bajo

//added comment
class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var dataSource = [Place]() {
        didSet {
            mapView.addAnnotations(dataSource)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPlacesFromDatabase()
        
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)

        
//        let span = MKCoordinateSpanMake(0.1, 0.1)
//        let region = MKCoordinateRegionMake(dataSource[0].coordinate, span)
//        mapView.setRegion(region, animated: true)
    }
    
    func fetchPlacesFromDatabase() {
        if let results = CoreDataManager.shared.fetchPlaces() {
            dataSource = results
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "showPlaceDetailSegue", sender: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaceDetailSegue" {
            let place = mapView.selectedAnnotations.first as! Place
            (segue.destination as! PlaceViewController).place = place
            mapView.deselectAnnotation(place, animated: false)
        }
    }
    
}



//
//  PlaceViewController.swift
//  PlacesBelgrade
//
//  Created by Natasa Javorina on 8/7/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit


class PlaceViewController: UIViewController {
    
    var place: Place?
    
    @IBOutlet var placeName: UILabel!
    @IBOutlet var placeCity: UILabel!
    @IBOutlet var placeAdress: UILabel!
    @IBOutlet var placeDesc: UITextView!
    @IBOutlet var placeImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        placeName.text = place?.name
        placeCity.text = place?.city
        placeAdress.text = place?.address
        placeDesc.text = place?.placeDescription
        placeImg.downloadImage(imageUrl: (place?.placeImgUrl!)!, completion: {
            self.placeImg.setNeedsLayout()
            self.placeImg.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

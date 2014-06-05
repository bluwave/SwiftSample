//
//  MapViewController.swift
//  SwiftSample
//
//  Created by Garrett Richards on 6/2/14.
//
//

import UIKit
import MapKit

class MapViewController: UIViewController ,MKMapViewDelegate {
    
    @IBOutlet var map: MKMapView

    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionGoToRegion(nil)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        if self.navigationController.viewControllers[self.navigationController.viewControllers.count-1] == self
//        {
//            
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionGoToRegion(sender: AnyObject?)
    {
        //37.7789027,-122.4285878
        let coord = CLLocationCoordinate2D(latitude: 37.7789027, longitude: -122.4285878 )
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.8)
        let region = MKCoordinateRegion(center: coord, span: span)
        self.map.setRegion(region, animated: true)
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

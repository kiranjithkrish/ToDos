//
//  ToDoItemDetailsViewController.swift
//  ToDo
//
//  Created by kiranjith on 26/03/2025.
//

import UIKit
import MapKit

class ToDoItemDetailsViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var todoStore: ToDoItemStoreProtocol?
    
    var todoItem: ToDoItem? {
        didSet {
            titleLabel.text = todoItem?.title
            if let timestamp = todoItem?.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
            descriptionLabel.text = todoItem?.description ?? "default description"
            locationLabel.text = todoItem?.location?.name ?? "default location"
            if let locationCordinate = todoItem?.location?.coordinate {
                mapView.setCenter(CLLocationCoordinate2D(latitude: locationCordinate.latitude, longitude: locationCordinate.longitude), animated: false)
            }
            doneButton.isEnabled = todoItem?.done == false
            
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let todoItem = todoItem, let store = todoStore {
            store.check(todoItem)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}

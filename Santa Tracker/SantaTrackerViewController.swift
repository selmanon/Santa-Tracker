//
//  ViewController.swift
//  Santa Tracker
//
//  Created by Abdellah SELASSI on 12/17/16.
//  Copyright © 2016 Dial. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class SantaTrackerViewController: UIViewController {
    @IBOutlet private weak var timeRemainingLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var activityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var presentsRemainingLabel: UILabel!
    
    // Has to be implicitly unwrapped
    // Needs the reference to the map view
    private var mapManager: MapManager!
    private var observerTokens = [NSObject: NotificationToken]()
    private let realmManager = SantaRealmManager()

    // We need this if Santa hasn't been downloaded
    private var notificationToken: NotificationToken?
    // We have to keep a strong reference to Santa for KVO to work
    private var santa: Santa?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up the map manager
        mapManager = MapManager(mapView: mapView)
        
        // Find the Santa data in Realm
        realmManager.logIn {
            // Be responsible in unwrapping!
            if let realm = self.realmManager.realm() {
                let santas = realm.objects(Santa.self)
                
                // Has Santa's info already been downloaded?
                if let santa = santas.first {
                    // Yep, so just use it
                    self.santa = santa
                    santa.addObserver(self)
                } else {
                    // Not yet, so get notified when it has been
                    self.notificationToken = santas.addNotificationBlock {
                        _ in
                        let santas = realm.objects(Santa.self)
                        if let santa = santas.first {
                            self.notificationToken?.stop()
                            self.notificationToken = nil
                            self.santa = santa
                            santa.addObserver(self)
                        }
                    }
                }
            }
        }
        
        // Find the Santa data in Realm
        let realm = try! Realm()
        let santas = realm.objects(Santa.self)
        
        // Set up the test Santa if he's not already there
        if santas.isEmpty {
            try? realm.write {
                realm.add(Santa.test())
            }
        }
        
        // Be responsible in unwrapping!
        if let santa = santas.first {
            // There used to be a call to mapManager in here, but not any more!
            santa.addObserver(self)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let santa = object as? Santa {
            update(with: santa)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func update(with santa: Santa) {
        mapManager.update(with: santa)
        let activity = santa.activity.description
        let presentsRemaining = "\(santa.presentsRemaining)"
        DispatchQueue.main.async {
            self.activityLabel.text = activity
            self.presentsRemainingLabel.text = presentsRemaining
        }
    }
    
    deinit {
        santa?.removeObserver(self)
    }

}


//
//  MapManager.swift
//  Santa Tracker
//
//  Created by Abdellah SELASSI on 12/17/16.
//  Copyright © 2016 Dial. All rights reserved.
//

import Foundation
import MapKit

class MapManager: NSObject{
    private let mapView: MKMapView
    private let santaAnnotation = MKPointAnnotation()
    private var routeOverlay: MKPolyline

    init(mapView: MKMapView) {
        self.mapView = mapView
        santaAnnotation.title = "🎅"
        routeOverlay = MKPolyline(coordinates: [], count: 0)
        super.init()
        mapView.addAnnotation(self.santaAnnotation)
    }
    
    func update(with santa: Santa){
        let santaLocation = santa.currentLocation.clLocationCoordinate2D
        let coordinates: [CLLocationCoordinate2D] = santa.route.flatMap({ $0.location?.clLocationCoordinate2D })
        DispatchQueue.main.async {
            self.santaAnnotation.coordinate = santaLocation
            self.mapView.remove(self.routeOverlay)
            self.routeOverlay = MKPolyline(coordinates: coordinates, count: coordinates.count)
            self.mapView.add(self.routeOverlay)
        }
    }
}

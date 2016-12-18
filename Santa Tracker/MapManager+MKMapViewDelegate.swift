//
//  MapManager+MKMapViewDelegate.swift
//  Santa Tracker
//
//  Created by Abdellah SELASSI on 12/18/16.
//  Copyright © 2016 Dial. All rights reserved.
//

import Foundation
import MapKit

extension MapManager: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard overlay is MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .black
        renderer.lineWidth = 3
        renderer.lineDashPattern = [3, 6]
        return renderer
    }
}

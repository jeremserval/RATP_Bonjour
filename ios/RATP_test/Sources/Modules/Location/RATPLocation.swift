//
//  RATPLocationManager.swift
//  RATP_test
//
//  Created by Jeremie Serval on 03/08/2022.
//

import Combine
import CoreLocation
import Foundation

class RATPLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager = CLLocationManager()
    @Published var coordinate: CLLocationCoordinate2D? = nil

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        let status: CLAuthorizationStatus = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
    }

    static func distanceInKilometer(current: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> String {
        let from: CLLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
        let to: CLLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        var distance = from.distance(from: to)
        if distance > 0.0 { distance /= 1000 }

        return String.init(format: "%.2f km", arguments: [distance])
    }
}

// Location manager functions
extension RATPLocationManager {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            case .denied, .restricted:
            break
        case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.coordinate = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
}

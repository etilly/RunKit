//
//  CLLocation+Extensions.swift
//  Pods
//
//  Created by Erwan TILLY on 27/08/2020.
//

import CoreLocation

extension CLLocation {
    func reverseGeocode(completion: @escaping (_ clPlacemarks: [CLPlacemark]?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}

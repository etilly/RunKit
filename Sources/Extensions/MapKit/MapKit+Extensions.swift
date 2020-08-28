//
//  MapKit+Extension.swift
//  shootproof
//
//  Created by Erwan TILLY on 27/02/2020.
//  Copyright © 2020 Niji. All rights reserved.
//

import MapKit

extension MKMapView {

    private var MERCATOR_OFFSET: Double {
        return 268_435_456.0
    }

    private var MERCATOR_RADIUS: Double {
        return 85_445_659.447_053_95
    }
	
	private var MAX_LEVELS: UInt {
		return 20
	}
	
	var BASE_RADIUS: Double {
		return 10_000
	}
	
	private var MAX_RADIUS: Double {
		return 30_000
	}

    private func longitudeToPixelSpaceX(longitude: Double) -> Double {
        return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * Double.pi / 180.0)
    }

    private func latitudeToPixelSpaceY(latitude: Double) -> Double {
        return round(MERCATOR_OFFSET - MERCATOR_RADIUS * log((1 + sin(latitude * Double.pi / 180.0)) / (1 - sin(latitude * Double.pi / 180.0))) / 2.0)
    }

    private  func pixelSpaceXToLongitude(pixelX: Double) -> Double {
        return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / Double.pi
    }

    private func pixelSpaceYToLatitude(pixelY: Double) -> Double {
        return (Double.pi / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / Double.pi
    }

    private func coordinateSpanWithMapView(mapView: MKMapView, centerCoordinate: CLLocationCoordinate2D, zoomLevel: UInt) -> MKCoordinateSpan {
        let centerPixelX = longitudeToPixelSpaceX(longitude: centerCoordinate.longitude)
        let centerPixelY = latitudeToPixelSpaceY(latitude: centerCoordinate.latitude)

        let zoomExponent = Double(MAX_LEVELS - zoomLevel)
        let zoomScale = pow(2.0, zoomExponent)

        let mapSizeInPixels = mapView.bounds.size
        let scaledMapWidth = Double(mapSizeInPixels.width) * zoomScale
        let scaledMapHeight = Double(mapSizeInPixels.height) * zoomScale

        let topLeftPixelX = centerPixelX - (scaledMapWidth / 2)
        let topLeftPixelY = centerPixelY - (scaledMapHeight / 2)

        // find delta between left and right longitudes
        let minLng = pixelSpaceXToLongitude(pixelX: topLeftPixelX)
        let maxLng = pixelSpaceXToLongitude(pixelX: topLeftPixelX + scaledMapWidth)
        let longitudeDelta = maxLng - minLng

        let minLat = pixelSpaceYToLatitude(pixelY: topLeftPixelY)
        let maxLat = pixelSpaceYToLatitude(pixelY: topLeftPixelY + scaledMapHeight)
        let latitudeDelta = -1 * (maxLat - minLat)

		return MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }

    func zoom(centerCoordinate: CLLocationCoordinate2D, zoomLevel: UInt) {
        let zoomLevel = min(zoomLevel, MAX_LEVELS)
        let span = self.coordinateSpanWithMapView(mapView: self, centerCoordinate: centerCoordinate, zoomLevel: zoomLevel)
		let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        setRegion(region, animated: true)
    }
	
	func getZoomLevel() -> UInt {
		let longitudeDelta = region.span.longitudeDelta
		let mapWidthInPixels = bounds.size.width
		let zoomScale = longitudeDelta * MERCATOR_RADIUS * Double.pi / Double(180.0 * mapWidthInPixels)
		var zoomer = 20 - log2(zoomScale)
		zoomer = zoomer < 0 ? 0 : zoomer
		zoomer = round(zoomer)
		return UInt(zoomer)
	}
	
	func topLeftCoordinate() -> CLLocationCoordinate2D {
        return convert(.zero, toCoordinateFrom: self)
    }

    func bottomRightCoordinate() -> CLLocationCoordinate2D {
        return convert(CGPoint(x: frame.width, y: frame.height), toCoordinateFrom: self)
    }
	
	func topCenterCoordinate() -> CLLocationCoordinate2D {
        return self.convert(CGPoint(x: self.frame.size.width / 2.0, y: 0), toCoordinateFrom: self)
    }

    func currentRadius() -> Double {
        let centerLocation = CLLocation(latitude: self.centerCoordinate.latitude, longitude: self.centerCoordinate.longitude)
        let topCenterCoordinate = self.topCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
		var distance = centerLocation.distance(from: topCenterLocation)
		if distance > MAX_RADIUS {
			distance = MAX_RADIUS
		}
        return distance
    }
}

extension CLLocationCoordinate2D {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

//
//  Basemap.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/17/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import UIKit
import MapKit

// MARK: Global Constants
let basemaps = Basemaps()

struct Basemap {
	var coordinate: CLLocationCoordinate2D
	let overlay: MKTileOverlay
	let name: String
	let span: MKCoordinateSpan
}

// This is hard coded now, consider converting to codable and using a JSON file for data
struct Basemaps {
	let OpenStreetMaps = Basemap(
		coordinate: CLLocationCoordinate2D(latitude: 40.774669555422349, longitude: -73.964170794293238),
		overlay:MKTileOverlay(urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
		name: "Open Street Map",
		span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
	)
	let MiddleEarth = Basemap(
		coordinate: CLLocationCoordinate2D(latitude: 8.951000, longitude: 8.987600),
		overlay: localBasemap(),
		name: "Middle Earth",
		span: MKCoordinateSpan(latitudeDelta: 9, longitudeDelta: 9)
	)
}


// This class is hard coded for testing with local map tiles
class localBasemap: MKTileOverlay {
	override func url(forTilePath path: MKTileOverlayPath) -> URL {
			let tilePath = Bundle.main.url(
				forResource: "\(path.y)",
				withExtension: "png",
				subdirectory: "tiles/\(path.z)/\(path.x)",
				localization: nil
			)
			guard let tile = tilePath else {
				return Bundle.main.url(
					forResource: "parchment",
					withExtension: "png",
					subdirectory: "tiles",
					localization: nil)!
			}
			return tile
		}
}


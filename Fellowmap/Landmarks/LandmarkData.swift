//
//  LandmarkData.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/17/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import Foundation
import MapKit

class LandmarkData {

	var overlays: [MKOverlay]
	var landmarks: [Landmark]
	var categoryGroups: [LandmarkCategoryGroup]

	init() {
		overlays = [MKOverlay]()
		landmarks = [Landmark]()
		categoryGroups = [LandmarkCategoryGroup]()
			
		// Setup category groups
		let defaults = UserDefaults.standard
		let groupDefaults = defaults.dictionary(forKey: "landmarkCategoryGroups") as? [String: Bool]
		
		for a in landmarkCategoryGroups {
			var show = true
			if groupDefaults != nil {
				show = groupDefaults?[a] ?? true
			}
			categoryGroups.append(LandmarkCategoryGroup(name: a, landmarks: [],show: show))
		}
				
		/*
		This will eventualy likely be a URL. It is set to the test data of just cities exported from QGIS.
		*/
		if let jsonUrl = Bundle.main.url(forResource: "MECities3", withExtension: "geojson") {
			do {
				let eventData = try Data(contentsOf: jsonUrl)

				/*
				 Use the MKGeoJSONDecoder to convert the JSON data into MapKit
				 objects, such as MKGeoJSONFeature.
				*/
				let decoder = MKGeoJSONDecoder()
				let jsonObjects = try decoder.decode(eventData)

				parse(jsonObjects)

			} catch {
				print("Error decoding GeoJSON: \(error).")
			}
		}
	}

	private func parse(_ jsonObjects: [MKGeoJSONObject]) {
		for object in jsonObjects {

			/*
			 In this sample's GeoJSON data there are only features in the
			 top-level so this parse method only checks for those. In a generic
			 parser, check for geometry objects here too.
			*/
			if let feature = object as? MKGeoJSONFeature {
				for geometry in feature.geometry {

					/*
					 Separate out annotation objects from overlay objects
					 because they are added to the map view in different ways.
					 This sample GeoJSON only contains points and multipolygon
					 geometry. In a generic parser, check for all possible
					 geometry types.
					*/
					if let multiPolygon = geometry as? MKMultiPolygon {
						overlays.append(multiPolygon)
					} else if let point = geometry as? MKPointAnnotation {
						let decoder = JSONDecoder()
						guard
							let properties = feature.properties,
							let dictionary = try? decoder.decode([String: String].self, from: properties),
							let title = dictionary["Name"],
							let category = dictionary["TYPE"]
						else {
							return
						}
						// Determine category group
						var categoryGroup = "unknown"
						if landmarkCategoryGroups.contains(category) {
							categoryGroup = category
						} else {
							categoryGroup = "other"
						}
						
						// Create landmark
						let landmark = Landmark(
							title: title,
							category: category,
							coordinate: point.coordinate,
							categoryGroup: categoryGroup)
						landmarks.append(landmark)

						// Add landmark to appropriate group
						for (index, _) in categoryGroups.enumerated() {
							if categoryGroups[index].name == landmark.categoryGroup {
								categoryGroups[index].landmarks.append(landmark)
							}
						}
					}
				}
			}
		}
	}
}

//
//  LandmarkData.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/17/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import UIKit
import MapKit

class Landmark: NSObject, MKAnnotation {
	
	var title: String?
	var category: String?
	let coordinate: CLLocationCoordinate2D
	var categoryGroup: String?
	
	init(title: String?, category: String?, coordinate: CLLocationCoordinate2D, categoryGroup: String?) {
		self.title = title
		self.category = category
		self.coordinate = coordinate
		self.categoryGroup = categoryGroup
	
	super.init()
	}
}

//
//  LandmarkCategoryGroup.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/18/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import Foundation

// Categories from City export
let landmarkCategoryGroups: Set = ["City", "Fortress", "Haven", "other", "unknown"]

struct LandmarkCategoryGroup {
	let name: String
	var landmarks: [Landmark]
	var show = true
}

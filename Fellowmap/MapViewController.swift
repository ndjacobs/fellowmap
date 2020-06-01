//
//  MapViewController.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/15/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import UIKit
import MapKit
import os.log

class MapViewController: UIViewController, MKMapViewDelegate {
	
	// MARK: IBOutlets
	@IBOutlet weak var mapView: MKMapView!
	
	
	// MARK: Properties
	var basemap = basemaps.MiddleEarth
	var landmarkGroups = [LandmarkCategoryGroup]()
	var landmarks = [Landmark]()
	let defaults = UserDefaults.standard
//	var mapView = MKMapView()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupTileRenderer()
		setupCamera()
		setupLandmarks()
		
		mapView.delegate = self
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		// Get the new view controller using segue.destination.
		switch segue.identifier ?? "" {
		case "ShowMapSettings":
			guard let MapSettingsViewController = segue.destination as? MapSettingsViewController else {
				fatalError("Unexpected destination: \(segue.destination)")
			}
			let index = MapSettingsViewController.children.firstIndex(of: LandmarkCategoryTableViewController())!
			
			let landmarkCategoryTableViewController = MapSettingsViewController.children[index] as? LandmarkCategoryTableViewController
			
			landmarkCategoryTableViewController?.landmarkGroups = landmarkGroups
			
			
		case "ShowLandmarkTable":
			guard let LandmarkTableViewController = segue.destination as? LandmarkCategoryTableViewController else {
				fatalError("Unexpected destination: \(segue.destination)")
			}
			print("Showing Landmark Table")
			LandmarkTableViewController.landmarkGroups = landmarkGroups
		
		default:
			fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
		}
		
		// Pass the selected object to the new view controller.
		
    }


	//MARK: Actions
//	func unwindToMap(sender: UIStoryboardSegue) {
//		if let sourceViewController = sender.source as? MapSettingsViewController {
//			if let LandmarkCategoryTable = sourceViewController.children contains(LandmarkCategoryTableViewController)
//		}
//	}
	
	
	// MARK: Basemap
	func setupTileRenderer() {
		let overlay = basemap.overlay
		overlay.canReplaceMapContent = true
		mapView.addOverlay(overlay)
	}
	
	func setupCamera() {
		let region = MKCoordinateRegion(center: basemap.coordinate, span: basemap.span)
		
		// Zoom range is currently hard coded for the local tiles
		let cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: CLLocationDistance(135000.0), maxCenterCoordinateDistance: CLLocationDistance(6000000.0))
		mapView.setCameraZoomRange(cameraZoomRange, animated: true)
		
		//Camera boundary
		let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: region)
		mapView.setCameraBoundary(cameraBoundary, animated: true)
		
		//Set initial visible region
		mapView.setRegion(region, animated: true)
	}
	
	//MARK: Landmarks
	func setupLandmarks() {
		
		// Load landmark groups
		landmarkGroups = loadLandmarks()
		
		// Add landmarks from show groups
		for group in landmarkGroups {
			if group.show {
				landmarks.append(contentsOf: group.landmarks)
			}
		}
		mapView.addAnnotations(landmarks)
	}
	
	func updateLandmarks() {
		// Clear currently displayed landmarks
		mapView.removeAnnotations(mapView.annotations)
		
		// Set show groups from user defaults and add landmarks from show groups
		let defaults = UserDefaults.standard
		let groupDefaults = defaults.dictionary(forKey: "landmarkCategoryGroups") as? [String: Bool]
			
		for (Index, _) in landmarkGroups.enumerated() {
			if groupDefaults != nil {
				landmarkGroups[Index].show = groupDefaults?[landmarkGroups[Index].name] ?? false
			}
			if landmarkGroups[Index].show {
				landmarks.append(contentsOf: landmarkGroups[Index].landmarks)
			}
		}
		mapView.addAnnotations(landmarks)
	}
	
	// MARK: MapView Delegate
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay is MKTileOverlay {
			let renderer = MKTileOverlayRenderer(tileOverlay: overlay as! MKTileOverlay)
			return renderer
		}
		return MKOverlayRenderer()
	}
	
	
	//MARK: Private Methods
	
	private func loadLandmarks() -> [LandmarkCategoryGroup] {
		let data = LandmarkData()
		var categoryGroups = data.categoryGroups
		categoryGroups.sort {
				$0.name < $1.name
		}
		return categoryGroups
	}
}

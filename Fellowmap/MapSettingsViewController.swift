//
//  MapSettingsViewController.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/21/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import UIKit

class MapSettingsViewController: UIViewController {

	//MARK: Properties
	//Passed from MapViewContoller
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
    }
    


	//MARK: Navigation
	@IBAction func dismissButton(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "ShowLandmarkCategoryTableView" {
//			let LandmarkCategoryTableViewController = segue.destination as! LandmarkCategoryTableViewController
//		}
//		
//		// Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }

	
	

}

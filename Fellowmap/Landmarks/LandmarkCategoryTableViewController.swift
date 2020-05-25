//
//  LandmarkCategoryTableViewController.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/17/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import UIKit
import os.log

class LandmarkCategoryTableViewController: UITableViewController {

	//MARK: Properties
	
	// This is passed by the MapViewController
	var landmarkGroups: [LandmarkCategoryGroup]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return landmarkGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
		// Table view cells are resused and should be dequeued using a cell identifier
		let cellIdentifier = "LandmarkCategoryTableViewCell"
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LandmarkCategoryTableViewCell else {
			fatalError("The dequeued cell is not an instance of LandmarkCategoryTableViewCell")
		}

        // Fetches the appropriate category groups for the data source layout.
		
		if let group = landmarkGroups?[indexPath.row] {
		
			cell.nameLabel.text = group.name
			cell.showSwitch.isOn = group.show
		}
		return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
		
		
    }
    

	//MARK: Actions
	
	
	
	
	//MARK: Private Methods
	
	private func loadCategories() -> [LandmarkCategoryGroup] {
		let data = LandmarkData()
		var categoryGroups = data.categoryGroups
		categoryGroups.sort {
				$0.name < $1.name
		}
		return categoryGroups
	}
}

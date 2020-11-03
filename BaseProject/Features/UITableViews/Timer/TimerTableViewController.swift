//
//  TimerTableViewController.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/26/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

class TimerTableViewController: UITableViewController {

    
    // MARK: - variant
    var timer: Timer?
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: TimerTableViewCell.classId, bundle: nil), forCellReuseIdentifier: TimerTableViewCell.classId)
        
        createTimer()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 40
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimerTableViewCell.classId, for: indexPath) as? TimerTableViewCell else {
            fatalError("Can't dequeue reusable cell")
        }
        cell.lbTitle.text = "\(indexPath.row)"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Timer update Cell
extension TimerTableViewController {
    
    @objc func udpateTimerInCell() {
        index += 1
        guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in visibleRowsIndexPaths {
            
            if let cell = tableView.cellForRow(at: indexPath) as? TimerTableViewCell {
                cell.udpateTime(index)
                // TODO: - update time in here
            }
        }
    }
    
    func createTimer() {
        if timer == nil {
            let timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(udpateTimerInCell),
                                         userInfo: nil,
                                         repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            
            self.timer = timer
        }
    }
}

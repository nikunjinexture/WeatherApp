//
//  RepeatDayPicker.swift
//  weatherApp
//
//  Created by InexTure on 05/12/18.
//  Copyright © 2018 INX. All rights reserved.
//

import UIKit

class RepeatDayPicker: UIViewController{

    //MARK:- Outlets
    @IBOutlet var tblRepeatDayPicker: UITableView!
    
    /* Variables */
    var selectedIndex = NSMutableIndexSet()
    var arrayDays = ["Everyday","Weekdays","Weekends","Every Monday","Every Tuesday","Every Wednesday","Every Thursday","Every Friday","Every Saturday","Every Sunday"]
    
    override func viewDidLoad(){
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RepeatDayPicker:UITableViewDataSource,
UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepeatCell", for: indexPath)
        cell.textLabel?.text = arrayDays[indexPath.row]
        if selectedIndex.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex.contains(indexPath.row) {
            if indexPath.row == 0 {
                selectedIndex.remove(indexPath.row)
                for i in 3..<10 {
                    selectedIndex.remove(i)
                }
                
                if selectedIndex.contains(1) {
                    for i in 3..<8 {
                        selectedIndex.add(i)
                    }
                }
                if selectedIndex.contains(2) {
                    for i in 8..<10 {
                        selectedIndex.add(i)
                    }
                }
                
            }
            else if indexPath.row == 1 {
                selectedIndex.remove(indexPath.row)
                for i in 3..<8 {
                    selectedIndex.remove(i)
                }
                if selectedIndex.contains(0) {
                    for i in 3..<10 {
                        selectedIndex.add(i)
                    }
                }
                if selectedIndex.contains(2) {
                    for i in 8..<10 {
                        selectedIndex.add(i)
                    }
                }
            }
            else if indexPath.row == 2 {
                selectedIndex.remove(indexPath.row)
                for i in 8..<10 {
                    selectedIndex.remove(i)
                }
                if selectedIndex.contains(0) {
                    for i in 3..<10 {
                        selectedIndex.add(i)
                    }
                }
                if selectedIndex.contains(1) {
                    for i in 3..<8 {
                        selectedIndex.add(i)
                    }
                }
            }
            else {
                selectedIndex.remove(indexPath.row)
                if !selectedIndex.contains(in: NSRange(location: 3, length: 7)) {
                    selectedIndex.remove(0)
                }
                if !selectedIndex.contains(in: NSRange(location: 3, length: 5)) {
                    selectedIndex.remove(1)
                }
                if !selectedIndex.contains(in: NSRange(location: 8, length: 2)) {
                    selectedIndex.remove(2)
                }
            }
        }
        else {
            if indexPath.row == 0 {
                selectedIndex.add(indexPath.row)
                for i in 3..<10 {
                    selectedIndex.add(i)
                }
            }
            else if indexPath.row == 1 {
                selectedIndex.add(indexPath.row)
                for i in 3..<8 {
                    selectedIndex.add(i)
                }
            }
            else if indexPath.row == 2 {
                selectedIndex.add(indexPath.row)
                for i in 8..<10 {
                    selectedIndex.add(i)
                }
            }
            else {
                selectedIndex.add(indexPath.row)
                if selectedIndex.contains(in: NSRange(location: 3, length: 7)) {
                    selectedIndex.add(0)
                }
                if selectedIndex.contains(in: NSRange(location: 3, length: 5)) {
                    selectedIndex.add(1)
                }
                if selectedIndex.contains(in: NSRange(location: 8, length: 2)) {
                    selectedIndex.add(2)
                }
            }
        }
        tableView.reloadData()
    }
    
}




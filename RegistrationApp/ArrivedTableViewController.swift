//
//  ArrivedTableViewController.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 3/12/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit
import os.log
import MessageUI

//Switch state that coincides with Logo
var switchState = true

class ArrivedTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    //Outlets
    @IBOutlet weak var ArrivedCounter: UILabel!
    @IBOutlet weak var TotalGuestCounter: UILabel!
    @IBOutlet weak var logoSwitcher: UISwitch!
    
    //Switch state changed function
    @IBAction func switchLogo(_ sender: UISwitch) {
        if(sender.isOn == true){
            switchState = true
        }else{
            switchState = false
        }
    }
    
    //When ArrivedTableViewController is loaded, this initializes it's componenets.
    override func viewDidLoad() {
        super.viewDidLoad()
        TotalGuestCounter.text = String(guests.count)
        ArrivedCounter.text = String(arrivedGuests.count)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(export))
        logoSwitcher.isOn = switchState
        
    }

    //This function deals with exporting a arrived guest list as a cvs file.
    @objc func export(_ sender: UIBarButtonItem){
    os_log("Export Button pressed", log: OSLog.default, type: .debug)
        let fileName = "ArrivedGuestList.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Const Id,First Name,Last Name,Email,Phone Number,Guest Of,Number,Balance Due\n"
        for guest in arrivedGuests{
            let newLine = "\(guest.constId),\(guest.firstName),\(guest.lastName),\(guest.email),\(guest.cellPhone),\(guest.guestOf),\(guest.number),\(guest.balanceDue)\n"
            csvText.append(newLine)
            do {
                try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
                let vc = UIActivityViewController(activityItems: [path!], applicationActivities: [])
                vc.excludedActivityTypes = [
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.postToFlickr,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.postToTencentWeibo,
                    UIActivity.ActivityType.postToTwitter,
                    UIActivity.ActivityType.postToFacebook,
                    UIActivity.ActivityType.openInIBooks,
                    UIActivity.ActivityType.copyToPasteboard,
                    UIActivity.ActivityType.addToReadingList
                ]
            present(vc, animated: true)
            if let popOver = vc.popoverPresentationController {
                popOver.sourceView = self.view
                }
            } catch {
                os_log("Failed", log: OSLog.default, type: .debug)
            }
        }
    }
    
    //Table view data source. Allows for deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrivedGuests.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ArrivedCounter.text = String(arrivedGuests.count)
            dump(arrivedGuests)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivedGuests.count
    }

    //Initializes the values in each guest cell with the guest values saved in the arrivedGuests array.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell indentifier
        let cellIdentifier = "ArrivedCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArrivedGuestTableViewCell else{
            fatalError("The Dequeued cell is not an instance of ArrivedGuestTableViewCell")
        }
        DispatchQueue.main.async
            {
                cell.arrivedBack.layer.cornerRadius = 10.0;
                cell.arrivedFront.roundCorners([.topRight, .bottomRight], radius: 10)
        }
        cell.arrivedConstID.text = arrivedGuests[indexPath.row].constId
        cell.arrivedFirstName.text = arrivedGuests[indexPath.row].firstName
        cell.arrivedLastName.text = arrivedGuests[indexPath.row].lastName
        cell.arrivedEmail.text = arrivedGuests[indexPath.row].email
        cell.arrivedPhoneNumber.text = arrivedGuests[indexPath.row].cellPhone
        cell.arrivedGuestOf.text = arrivedGuests[indexPath.row].guestOf
        cell.arrivedNumber.text = arrivedGuests[indexPath.row].number
        cell.arrivedBalanceDue.text = arrivedGuests[indexPath.row].balanceDue
        
        return cell
     }
}

//Round Corners for cells.
extension UIView {
    
    func roundCorner(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask

    }
}

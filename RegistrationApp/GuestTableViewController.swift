//
//  GuestTableViewController.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 1/4/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

//MARK: Notes
//guests[] = The orignal array from guest list.
//currentGuestArray[] = The constantly updated guest array.
//updatedArray[] = Updated array for search bar function.
//arrivedGuests[] = Arrived guests array.

import UIKit
import os.log

var firstCompletionTime = true
var guests = [Guest]()
var currentGuestArray = [Guest]() //update table
var updatedArray = [Guest]()
var arrivedGuests = [Guest]()
var orignalGuestArray = [Guest]()
var searchController: UISearchController!
var canSegue = true
var value = [Guest]()
var rowSelection = false;

class GuestTableViewController: UITableViewController , UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    //MARK: Properties
    
    var arrayNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.editButtonItem.title = "Select Party"
        loadGuestFile()
        navigationItem.titleView = searchBar
        //headerView.isHidden = true
        setUpSearchBar()
        tableView.tableFooterView = UIView(frame: .zero)
        //registerButton.isEnabled = false;
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        registerButton.isEnabled = true
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.indexPathsForSelectedRows == nil{
        registerButton.isEnabled = false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowDetail"{
            if self.isEditing == false{
                return true
            }
        }
        return false
        }
    
    override func setEditing (_ editing:Bool, animated:Bool)
    {
        super.setEditing(editing,animated:animated)
       
        if(self.isEditing)
        {
            headerView.backgroundColor = #colorLiteral(red: 0.6738977432, green: 0.6871618032, blue: 0.3302460313, alpha: 1)
             //headerView.isHidden = false
            self.editButtonItem.title = "Cancel"
        }else
        {
            headerView.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.4352941176, blue: 0.4156862745, alpha: 1)
            //headerView.isHidden = true
            self.editButtonItem.title = "Select Party"
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentGuestArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //Table view cells are reused and should be dequeued using a cell indentifier
        let cellIdentifier = "GuestTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GuestTableViewCell else{
            fatalError("The Dequeued cell is not an instance of GuestTableViewCell.")
            }
        DispatchQueue.main.async
            {
                cell.backView.layer.cornerRadius = 10.0;
                cell.frontView.roundCorners([.topRight, .bottomRight], radius: 10)
        }
        //Fetches the appropriate guest for the data source layout
        //let guest = guests[indexPath.row]
        
        cell.constIdLabel.text = currentGuestArray[indexPath.row].constId
        cell.firstNameLabel.text = currentGuestArray[indexPath.row].firstName
        cell.lastNameLabel.text = currentGuestArray[indexPath.row].lastName
        cell.emailLabel.text = currentGuestArray[indexPath.row].email
        cell.cellPhoneNumberLabel.text = currentGuestArray[indexPath.row].cellPhone
        cell.numberOfGuestLabel.text = currentGuestArray[indexPath.row].guestOf
        cell.numberLabel.text = currentGuestArray[indexPath.row].number
        if(cell.numberLabel.text == "none"){
            cell.Top.isHidden = true
            cell.numberLabel.isHidden = true;
        }else{
            cell.Top.isHidden = false
            cell.numberLabel.isHidden = false
        }
        cell.balanceDueLabel.text = currentGuestArray[indexPath.row].balanceDue
        if(cell.balanceDueLabel.text == "none"){
            cell.Bot.isHidden = true
            cell.balanceDueLabel.isHidden = true;
        }else{
            
            cell.Bot.isHidden = false
            
            cell.balanceDueLabel.isHidden = false
        }
        return cell
    }
    func loadURL(){
        
    }
    //SEARCH BAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentGuestArray = updatedArray
        guard !searchText.isEmpty else {
            currentGuestArray = updatedArray
            tableView.reloadData()
            return
        }
        currentGuestArray = guests.filter({ guest -> Bool in
            guest.lastName.contains(searchText) || guest.guestOf.contains(searchText) || guest.number.contains(searchText)
            })
        tableView.reloadData()
    }

    
    // MARK: - Navigation
    @IBAction func cancelToHome(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerMultiple(_ sender: UIBarButtonItem){
        //setEditing(true, animated: true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? ""){
        
        case "New Guest":
            os_log("Adding a new guest from home screen.", log: OSLog.default, type: .debug)
            
        case "AddGuest":
            os_log("Adding a new guest from guest list.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            os_log("Showing detail of selected guest.", log: OSLog.default, type: .debug)
            
            guard let guestDetailViewController = segue.destination as? GuestViewController else{
                    fatalError("Unexpected destination: \(segue.destination)")
        }
            guard let selectedGuestCell = sender as? GuestTableViewCell else{
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedGuestCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            //Setting select guest
            let selectedGuest = currentGuestArray[indexPath.row]
            guestDetailViewController.guest = selectedGuest
        default:
            fatalError("Unexpected Segue Indentifier; \(String(describing: segue.identifier))")
        }
    }
    
//MARK: Actions
    @IBAction func unwindToGuestList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            GuestViewController, let guest = sourceViewController.guest{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update existing guest
                os_log("Editing a guest.", log: OSLog.default, type: .debug)
                registerButton.isEnabled = false;
                currentGuestArray[selectedIndexPath.row] = guest
                //Adding selected guest to arrived
                arrivedGuests.append(guest)
                os_log("Added selected guest to arrived guests array", log: OSLog.default, type: .debug)
                dump(arrivedGuests)
                currentGuestArray = updatedArray
                tableView.reloadData()
            }else{
            //Add a new guest
            /*let newIndexPath = IndexPath(row: guests.count, section: 0)
            currentGuestArray.append(guest)
            updatedArray.append(guest)
            arrivedGuests.append(guest)
            tableView.insertRows(at: [newIndexPath], with: .automatic)*/
            }
        }
    }
    
    @IBAction func RegisterMultipleGuests(_ sender: Any) {
        let selected_indexPaths = tableView.indexPathsForSelectedRows
        for indexPath in selected_indexPaths!{
            arrivedGuests.append(currentGuestArray[indexPath.row])
        }
        tableView.reloadData()
        isEditing = false;
        registerButton.isEnabled = false;
        let homeScreen = storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeScreenViewController
        homeScreen.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(homeScreen, animated: true)
        }

    //MARK Private Methods
    private func loadGuestFile(){
        guard firstCompletionTime else{return}
            os_log("Load Guest List Function Called.", log: OSLog.default, type: .debug)
       /* if let filepath = Bundle.main.path(forResource: nil, ofType: "txt") {
                do {
                    let content = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
                    let readings = content.components(separatedBy: "\r") as [String]
                    
                    for i in 1..<(readings.count - 1){
                        let data = readings[i].components(separatedBy:"\t")
                        
                        guests.append(Guest(constId: "\(data[0])", firstName: "\(data[1])", lastName: "\(data[2])", email: "\(data[3])", cellPhone: "\(data[4])", guestOf: "\(data[5])", number: "\(data[6])", balanceDue: "\(data[7])")!)
                    }
                    currentGuestArray+=guests
                    //dump(guests)
                    updatedArray+=guests
                    orignalGuestArray += guests
                    
                } catch {
                    // contents could not be loaded
                    os_log("Contents could not be loaded.", log: OSLog.default, type: .debug)
                }
            } else {
                // example.txt not found!
                os_log("File not found.", log: OSLog.default, type: .debug)
            }*/
            firstCompletionTime = false
        }
    
    
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
   func delete(element: Guest) {
        dump(element)
        updatedArray = updatedArray.filter() { $0 != element }
    }
    
    //Saving arrived Guests
    private func saveGuests(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(arrivedGuests, toFile: Guest.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Guests successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save guests...", log: OSLog.default, type: .error)
        }
    }
    
    
}
extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

    


//-----------------Grave Yard-----------------
/*
 private func loadSampleGuests(){
 guests.append(Guest(firstName: "Justin", lastName: "Cullen", email: "jcullyt1@gmail.com", cellPhoneNumber: "203-530-2500", numberOfGuest: "1")!)
 guests.append(Guest(firstName: "John", lastName: "Petillo", email: "JohnPetillo@gmail.com", cellPhoneNumber: "1234567890", numberOfGuest: "1")!)
 guests.append(Guest(firstName: "Ludwig", lastName: "Spinelli", email: "LudwigSpinelli@gmail.com", cellPhoneNumber: "1234567890", numberOfGuest: "1")!)
 currentGuestArray += guests
 os_log("loadSampleGuests called.", log: OSLog.default, type: .debug)
 }

 os_log("test", log: OSLog.default, type: .debug)
 if let selectedIndexPath = tableView.indexPathForSelectedRow{
 //Update existing guest
 currentGuestArray[selectedIndexPath.row] = guest
 os_log("existing guest update called", log: OSLog.default, type: .debug)
 tableView.reloadRows(at: [selectedIndexPath], with: .none)
 }
 else{
 
 load any saved guests
 if let savedGuests = loadGuests(){
 currentGuestArray += savedGuests
 }
 
 private func saveGuests(){
 let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(currentGuestArray, toFile: Guest.ArchiveURL.path)
 
 if isSuccessfulSave {
 os_log("Guests successfully saved.", log: OSLog.default, type: .debug)
 } else {
 os_log("Failed to save guests...", log: OSLog.default, type: .error)
 }
 }
 
 private func loadGuests() -> [Guest]? {
 os_log("load guests called", log: OSLog.default, type: .debug)
 return NSKeyedUnarchiver.unarchiveObject(withFile: Guest.ArchiveURL.path) as? [Guest]    }
 }
 //MARK: Actions
 /*@IBAction func unwindToGuestList(sender: UIStoryboardSegue){
 if let sourceViewController = sender.source as?
 GuestViewController, let guest = sourceViewController.guest{
 os_log("test", log: OSLog.default, type: .debug)
 if let selectedIndexPath = tableView.indexPathForSelectedRow{
 //Update existing guest
 currentGuestArray[selectedIndexPath.row] = guest
 os_log("existing guest update called", log: OSLog.default, type: .debug)
 tableView.reloadRows(at: [selectedIndexPath], with: .none)
 }
 else{
 //Add a new guest
 let newIndexPath = IndexPath(row: currentGuestArray.count, section: 0)
 
 currentGuestArray.append(guest)
 tableView.insertRows(at: [newIndexPath], with: .automatic)
 }
 guestArrived()
 //saveGuests()
 }
 }*/
 */


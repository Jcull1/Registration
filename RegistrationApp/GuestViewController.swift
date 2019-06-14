//
//  GuestViewController.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 1/4/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit
import os.log
import TextFieldEffects

class GuestViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var constIdTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var BalanceDueTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cellPhoneTextField: UITextField!
    @IBOutlet weak var numberOfGuestTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var GuestTitle: UILabel!
    @IBOutlet weak var checkInTextField: UITextField!
    
 /*
 This value is either passed by "GuestTableViewController" in 'prepare(for:sender:)'
 or contructed as part of adding a new meal.
 */
    
    var guest: Guest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through the delegate callbacks
        constIdTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        cellPhoneTextField.delegate = self
        numberOfGuestTextField.delegate = self
        numberTextField.delegate = self
        BalanceDueTextField.delegate = self
        checkInTextField.delegate = self
        
        
        
        //Set up views if editing an existing guest.
        if let guest = guest{
            navigationItem.title = ""
            GuestTitle.text = "Is this information correct?"
            firstNameTextField.text = guest.firstName
            lastNameTextField.text = guest.lastName
            emailTextField.text = guest.email
            cellPhoneTextField.text = guest.cellPhone
            numberOfGuestTextField.text = guest.guestOf
            constIdTextField.text = guest.constId
            numberTextField.text = guest.number
            BalanceDueTextField.text = guest.balanceDue
            checkInTextField.text = guest.checkIn
            if(guest.number == "none"){
                numberTextField.isHidden = true
            }else{
                numberTextField.isHidden = false
            }
            if(guest.balanceDue == "none"){
                BalanceDueTextField.isHidden = true
            }else{
                BalanceDueTextField.isHidden = false
            }
        }
        //Enable the save button only if the text field has a valid guest name
        updateSaveButtonState()
    }
    //MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation, this view controller needs to be dismissed in 2 ways.
        let isPresentingInAddGuestMode = presentingViewController is UINavigationController
        if isPresentingInAddGuestMode{
         dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else{
            fatalError("The GuestViewController is not inside a navigation controller.")
        }
        
    }
    
    //MARK: Actions
    //This method lets you configure a view controller before its presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for:segue, sender: sender)
        //Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: . debug)
            return
        }
        let constId = constIdTextField.text ?? ""
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let cellPhone = cellPhoneTextField.text ?? ""
        let guestOf = numberOfGuestTextField.text ?? ""
        let number = numberTextField.text ?? ""
        let balanceDue = BalanceDueTextField.text ?? ""
        let checkIn = checkInTextField.text ?? ""
        
        guest = Guest(constId: constId, firstName: firstName, lastName: lastName, email: email, cellPhone: cellPhone, guestOf: guestOf, number: number, balanceDue: balanceDue, checkIn: checkIn)
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState(){
    }
}


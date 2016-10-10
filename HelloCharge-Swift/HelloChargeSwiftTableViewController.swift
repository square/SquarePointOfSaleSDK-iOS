//
//  HelloChargeTableViewController.swift
//  SquareRegisterSDK Tests
//
//  Created by Joseph Hankin on 9/23/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import SquareRegisterSDK
import UIKit


// FIXME: Replace this with the Application ID found in the Square Application Dashboard [https://connect.squareup.com/apps].
let yourClientID = "YOUR_APPLICATION_ID"

// FIXME: Replace with your app's callback URL as set in the Square Application Dashboard [https://connect.squareup.com/apps]
// You must also declare this URL scheme in HelloCharge-Swift-Info.plist, under URL types.
let yourCallbackURL = URL(string: "hellocharge://callback")!


enum Section: Int {
    case amount = 0, supportedTenderTypes, optionalFields, settings
}


let allTenderTypes: [SCCAPIRequestTenderTypes] = [.card, .cash, .other, .squareGiftCard]


extension String {
    var nilIfEmpty: String? {
        return isEmpty ? nil : self
    }
}


class HelloChargeSwiftTableViewController: UITableViewController {

    var supportedTenderTypes: SCCAPIRequestTenderTypes = .card
    var clearsDefaultFees = false
    var returnAutomaticallyAfterPayment = true
    
    @IBOutlet weak var currencyField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var userInfoStringField: UITextField!
    @IBOutlet weak var merchantIDField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Always set the client ID before creating your first API request.
        SCCAPIRequest.setClientID(yourClientID)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let section = Section(rawValue: indexPath.section) {
            switch section {
            case .supportedTenderTypes:
                let tenderTypeForRow = allTenderTypes[indexPath.row]
                let checked = supportedTenderTypes.contains(tenderTypeForRow)
                cell.accessoryType = (checked ? .checkmark : .none)
            case .settings:
                if indexPath.row == 0 {
                    cell.accessoryType = (clearsDefaultFees ? .checkmark : .none)
                } else if indexPath.row == 1 {
                    cell.accessoryType = (returnAutomaticallyAfterPayment ? .checkmark : .none)
                }
            case .amount, .optionalFields:
                return
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let section = Section(rawValue: indexPath.section) {
            switch section {
            case .supportedTenderTypes, .settings:
                return indexPath
            case .amount, .optionalFields:
                return nil
            }
        }
        
        return nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let section = Section(rawValue: indexPath.section) {
            switch section {
            case .supportedTenderTypes:
                let tenderTypeForRow = allTenderTypes[indexPath.row]
                supportedTenderTypes.formSymmetricDifference(tenderTypeForRow)
            case .settings:
                if indexPath.row == 0 {
                    clearsDefaultFees = !clearsDefaultFees
                } else if indexPath.row == 1 {
                    returnAutomaticallyAfterPayment = !returnAutomaticallyAfterPayment
                }
            case .amount, .optionalFields:
                return
            }
        }
        
        let cell = tableView.cellForRow(at: indexPath)!
        self.tableView(tableView, willDisplay:cell, forRowAt: indexPath)
    }
    
    // MARK: - Actions

    @IBAction func oauth(sender: AnyObject) {
        guard let oauthURL = URL(string: "https://squareup.com/oauth2/authorize?client_id=\(yourClientID)&scope=PAYMENTS_WRITE&response_type=token") else {
            return
        }
        UIApplication.shared.openURL(oauthURL)
    }
    
    @IBAction func charge(sender: AnyObject) {
        
        let currencyCodeString = currencyField.text?.nilIfEmpty ?? currencyField.placeholder!
        let amountString = amountField.text?.nilIfEmpty ?? amountField.placeholder!

        let amount: SCCMoney
        guard let amountCents = Int(amountString) else {
            showErrorMessage(title: "Invalid Amount", message: "\(amountString) is not a valid amount.")
            return
        }
        
        do {
            amount = try SCCMoney(amountCents: amountCents, currencyCode: currencyCodeString)
        } catch let error as NSError {
            showErrorMessage(title: "Invalid Amount", error: error)
            return
        }
        
        let userInfoString = userInfoStringField.text?.nilIfEmpty
        let merchantID = merchantIDField.text?.nilIfEmpty
        let notes = notesField.text?.nilIfEmpty

        let request: SCCAPIRequest
        do {
            request = try SCCAPIRequest(callbackURL: yourCallbackURL,
                                        amount: amount,
                                        userInfoString: userInfoString,
                                        merchantID: merchantID,
                                        notes: notes,
                                        supportedTenderTypes: supportedTenderTypes,
                                        clearsDefaultFees: clearsDefaultFees,
                                        returnAutomaticallyAfterPayment: returnAutomaticallyAfterPayment)
        } catch let error as NSError {
            showErrorMessage(title: "Invalid Amount", error: error)
            return
        }
        
        do {
            try SCCAPIConnection.perform(request)
        } catch let error as NSError {
            showErrorMessage(title: "Cannot Perform Request", error: error)
            return
        }
    }
    
    // MARK: - Private Methods
    
    private func showErrorMessage(title: String, error: NSError) {
        showErrorMessage(title: title, message: error.localizedDescription)
    }
    
    private func showErrorMessage(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}

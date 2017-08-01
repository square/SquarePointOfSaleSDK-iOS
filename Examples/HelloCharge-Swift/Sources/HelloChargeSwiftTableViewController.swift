//
//  HelloChargeTableViewController.swift
//  SquareRegisterSDK Tests
//
//  Created by Joseph Hankin on 9/23/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import SquarePointOfSaleSDK
import UIKit


// FIXME: Replace this with the Application ID found in the Square Application Dashboard [https://connect.squareup.com/apps].
let yourApplicationID = "YOUR_APPLICATION_ID"

// Replace with your app's callback URL as set in the Square Application Dashboard [https://connect.squareup.com/apps]
// You must also declare this URL scheme in HelloCharge-Swift-Info.plist, under URL types.
let yourCallbackURL = URL(string: "hellocharge://callback")!


enum Section: Int {
    case amount = 0, supportedTenderTypes, optionalFields, settings

    init?(at indexPath: IndexPath) {
        self.init(rawValue: indexPath.section)
    }
}


let allTenderTypes: [SCCAPIRequestTenderTypes] = [.card, .cash, .other, .squareGiftCard, .cardOnFile]


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
    @IBOutlet weak var locationIDField: UITextField!
    @IBOutlet weak var customerIDField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Always set the client ID before creating your first API request.
        SCCAPIRequest.setClientID(yourApplicationID)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if shouldShowCheckmark(for: indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let section = Section(at: indexPath) else {
            return nil
        }

        switch section {
        case .supportedTenderTypes, .settings:
            return indexPath
        case .amount, .optionalFields:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let section = Section(at: indexPath) {
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
        self.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    // MARK: - Actions

    @IBAction func oauth(sender: AnyObject) {
        guard let oauthURL = URL(string: "https://squareup.com/oauth2/authorize?client_id=\(yourApplicationID)&scope=PAYMENTS_WRITE&response_type=token") else {
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
        let locationID = locationIDField.text?.nilIfEmpty
        let customerID = customerIDField.text?.nilIfEmpty
        let notes = notesField.text?.nilIfEmpty

        let request: SCCAPIRequest
        do {
            request = try SCCAPIRequest(callbackURL: yourCallbackURL,
                                        amount: amount,
                                        userInfoString: userInfoString,
                                        locationID: locationID,
                                        notes: notes,
                                        customerID: customerID,
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
    private func shouldShowCheckmark(for indexPath: IndexPath) -> Bool {
        guard let section = Section(at: indexPath) else {
            return false
        }

        switch section {
        case .supportedTenderTypes:
            let tenderTypeForRow = allTenderTypes[indexPath.row]
            return supportedTenderTypes.contains(tenderTypeForRow)

        case .settings where indexPath.row == 0: return clearsDefaultFees
        case .settings where indexPath.row == 1: return returnAutomaticallyAfterPayment
        default: return false
        }
    }
    
    private func showErrorMessage(title: String, error: NSError) {
        showErrorMessage(title: title, message: error.localizedDescription)
    }
    
    private func showErrorMessage(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}

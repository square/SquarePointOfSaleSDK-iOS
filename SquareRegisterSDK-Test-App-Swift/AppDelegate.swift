//
//  AppDelegate.swift
//  SquareDemo
//
//  Created by Gareth Paul Jones on 6/29/2016.
//  Copyright (c) 2013 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = UIViewController.init()
        window!.backgroundColor = UIColor.whiteColor()
        window!.makeKeyAndVisible()
        
        // Always set the client ID before creating your first API request.
        SCCAPIRequest.setClientID("APPLICATION_ID")
        
        // Replace with your app's callback URL.
        let callbackURL = NSURL(string: "squareregisterdemo://Callback")
        
        // Specify the amount of money to charge.
        let amount = try! SCCMoney(amountCents: 100, currencyCode: "USD")
        
        // Specify which forms of tender the merchant can accept
        let supportedTender = SCCAPIRequestTenderTypes.Card
        
        // Specify whether default fees in Square Register are cleared from this transaction
        // (Default is NO, they are not cleared)
        let clearsDefaultFees = true
        
        // Replace with the current merchant's ID.
        let merchantID = "YOUR_MERCHANT_ID"
        
        // Replace with any string you want returned from Square Register.
        let userInfoString = "Useful information"
        
        // Replace with notes to associate with the transaction.
        let notes = "Notes"
        
        // Initialize the request.
        let requestWithCallbackURL = try! SCCAPIRequest(callbackURL: callbackURL!,
                                                        amount: amount,
                                                        userInfoString: userInfoString,
                                                        merchantID: merchantID,
                                                        notes: notes,
                                                        supportedTenderTypes: supportedTender,
                                                        clearsDefaultFees: clearsDefaultFees,
                                                        returnAutomaticallyAfterPayment: false)
        
        // Perform the request.
        do {
            try SCCAPIConnection.performRequest(requestWithCallbackURL)
        } catch {
            let alertView = UIAlertController(title: "Register app installed?", message: "Make sure the Square Register app is installed", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
            window!.rootViewController!.presentViewController(alertView, animated: true, completion: nil)

            alertView.show()
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        // Make sure the URL comes from Square Register, fail if it doesn't.
        guard let srcApp = sourceApplication else { return false }
        if !srcApp.hasPrefix("com.squareup.square") {
            return false
        }
        
        var message: String!
        var title: String!
        let response: SCCAPIResponse = try! SCCAPIResponse(responseURL: url)
        
        if response.successResponse {
            title = "Success!"
            message = "Payment creation succeeded with payment ids \(response.paymentID!) \(response.offlinePaymentID!), transaction ID: \(response.transactionID!)"
        } else {
            let errorToPresent = response.error!
            title = "Failure"
            message = "Payment creation failed with error: \(errorToPresent.localizedDescription)"
        }
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        window!.rootViewController!.presentViewController(alertView, animated: true, completion: nil)
        
        return true
    }
    
}

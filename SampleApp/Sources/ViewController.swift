//
//  ViewController.swift
//  SampleApp
//
//  Created by Mike Silvis on 3/27/20.
//  Copyright © 2020 Yab. All rights reserved.
//

import UIKit
import SquarePointOfSaleSDK

class ViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Request", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapStartRequest), for: .touchDown)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapStartRequest() {
        // Replace with your app's URL scheme.
        let callbackURL = URL(string: "<#T##Your URL Scheme##String#>://")!

        // Your client ID is the same as your Square Application ID.
        // Note: You only need to set your client ID once, before creating your first request.
        SCCAPIRequest.setClientID("<#T##Your Application ID##String#>")

        do {
            // Specify the amount of money to charge.
            let money = try SCCMoney(amountCents: 100, currencyCode: "USD")

            // Create the request.
            let apiRequest =
                try SCCAPIRequest(
                    callbackURL: callbackURL,
                    amount: money,
                    userInfoString: nil,
                    locationID: nil,
                    notes: "Coffee",
                    customerID: nil,
                    supportedTenderTypes: .all,
                    clearsDefaultFees: false,
                    returnAutomaticallyAfterPayment: false
            )

            // Open Point of Sale to complete the payment.
            try SCCAPIConnection.perform(apiRequest)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}


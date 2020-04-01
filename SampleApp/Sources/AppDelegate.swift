//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Mike Silvis on 3/27/20.
//  Copyright © 2020 Yab. All rights reserved.
//

import UIKit
import SquarePointOfSaleSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard SCCAPIResponse.isSquareResponse(url) else {
            return false
        }

        do {
            let response = try SCCAPIResponse(responseURL: url)

            if let error = response.error {
                // Handle a failed request.
                print(error.localizedDescription)
            } else {
                // Handle a successful request.
            }

        } catch let error as NSError {
            // Handle unexpected errors.
            print(error.localizedDescription)
        }

        return true
    }
}


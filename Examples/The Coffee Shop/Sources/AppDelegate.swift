//
//  Copyright © 2017 Square, Inc.
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
import SquarePointOfSaleSDK

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private lazy var appFlowController = AppFlowController(drinks: DrinkMenu.all)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if SquareApplicationId == "your_application_id" {
            fatalError("Set your application identifier in Config.swift. To get your application identifier, visit connect.squareup.com/apps and create a new application.")
        }
        
        if SquareApplicationId.hasPrefix("sandbox") {
            fatalError("Sandbox application identifiers are not supported in Point of Sale API.")
        }
        
        // You only need to set your client id once
        SCCAPIRequest.setClientID(SquareApplicationId)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appFlowController
        window?.makeKeyAndVisible()
        return true
    }
    
    /// This method is called when the Point of Sale app calls back to your app after the transaction completes or is canceled
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let sourceApp = options[.sourceApplication] as? String, sourceApp.hasPrefix("com.squareup.square"),
            let response = try? SCCAPIResponse(responseURL: url) {
            
            appFlowController.handlePointOfSaleAPIResponse(response)
            return true
        }
        return false
    }
}

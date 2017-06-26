# Hello Charge Swift

This is a demo app that demonstrates how to use [SquarePointOfSaleSDK](https://github.com/square/SquarePointOfSaleSDK-iOS) to accept in-person payments.

## Configuring the App

- Create a [Square developer account](https://squareup.com/signup?v=developers) or log in with your existing Square merchant account
- Once you're logged in, open the [application dashboard](https://connect.squareup.com/apps) and set up a new application
- Now switch to the Point of Sale API tab and add the bundle identifier and URL scheme for this demo app:
- Bundle Identifier: `com.squareup.HelloCharge-Swift`
- URL Scheme: `hellocharge`
- Open `HelloChargeSwiftTableViewController.swift` and paste in the Application ID for the application you just created. You can find this in your application dashboard under the 'Credentials' tab.

## Running the App

- In order to accept payments you will need to download the free Square Point of Sale app from the App Store and log in using the same Square account you set up earlier.

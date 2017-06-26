# The Coffee Shop

This is a demo app that uses [SquarePointOfSaleSDK](https://github.com/square/SquarePointOfSaleSDK-iOS) to accept in-person payments at a fictional coffee shop. You will need to set up a Square Developer Account in order to run this app.

## Configuring the App

- Create a [Square developer account](https://squareup.com/signup?v=developers) or log in with your existing Square merchant account
- Once you're logged in, open the [application dashboard](https://connect.squareup.com/apps) and set up a new application
- Now switch to the Point of Sale API tab and add the bundle identifier and URL scheme for this demo app:
    - Bundle Identifier: `com.squareup.coffeeshop`
    - URL Scheme: `coffeeshop`
- Open `Config.swift` and paste in the Application ID for the application you just created. You can find this in your application dashboard under the 'Credentials' tab.

## Running the App

- Download the free Square Point of Sale app from the App Store and log in using the same Square account you set up earlier.

- Open the Xcode project in the Examples directory and install the app to your iPad.

- Tap on a drink, customize it and tap "Check Out". If everything is set up correctly, your iPad will automatically switch to the Square Point of Sale app and allow you to pay for your drink. If you cancel or complete a payment, you will automatically be taken back to The Coffee Shop.

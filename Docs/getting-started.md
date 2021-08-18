# Square Point of Sale SDK

## Point of Sale SDK for iOS Overview
The Square Point of Sale SDK for iOS is an iOS implementation of the Square Point of Sale API. Using the Point of Sale SDK instead of using the Point of Sale API directly can simplify the development process.

The Point of Sale SDK is available on [Github](https://github.com/square/SquarePointOfSaleSDK-iOS), along with a helpful sample application that demonstrates its use.

To learn about the basics of the Point of Sale API, see [Using the Point of Sale API](https://developer.squareup.com/docs/pos-api/what-it-does).

## Setting up
Before you can use the Point of Sale SDK, you need to complete the tasks described in the [Build on iOS](https://developer.squareup.com/docs/pos-api/build-on-ios) guide.

## Usage

### Swift
**Import Declaration:** `import SquarePointOfSaleSDK`

```swift
// Replace with your app's URL scheme.
let callbackURL = URL(string: "<# Your URL Scheme #>://")!

// Your client ID is the same as your Square Application ID.
// Note: You only need to set your client ID once, before creating your first request.
SCCAPIRequest.setApplicationID("<# Application ID #>")

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
                returnsAutomaticallyAfterPayment: false,
                disablesKeyedInCardEntry: false,
                skipsReceipt: false
        )

    // Open Point of Sale to complete the payment.
    try SCCAPIConnection.perform(apiRequest)

} catch let error as NSError {
    print(error.localizedDescription)
}
```

Finally, implement the UIApplication delegate method as follows:

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    guard SCCAPIResponse.isSquareResponse(url) else {
        return true
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
```
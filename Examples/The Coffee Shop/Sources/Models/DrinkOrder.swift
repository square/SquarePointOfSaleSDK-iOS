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

/// An order that can be purchased by the customer. Combines a drink that has been selected by the customer and the customization options they chose.
struct DrinkOrder {
    let drink: Drink
    let options: [DrinkOption]
    
    var price: Int {
        return options.reduce(0) { total, option in
            total + option.price
        }
    }
}

extension DrinkOrder: CustomStringConvertible {
    var description: String {
        var description = "\(drink.name)"
        
        for option in options {
            description += "\n"
            let optionPrice = MoneyFormatter.string(for: option.price)
            description += "* \(option.name) (\(optionPrice))"
        }
        return description + "\n"
    }
}

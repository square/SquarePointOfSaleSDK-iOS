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

struct DrinkMenu {
    
    /// All drinks that are available for purchase
    static let all = [coffee, decaf, espresso, icedCoffee, hotChocolate, blackTea]
    
    // MARK: - Drinks
    
    static let coffee = Drink(name: "Coffee",
                              drinkDescription: "Smooth and balanced with subtle notes of chocolate.",
                              image: #imageLiteral(resourceName: "coffee"),
                              optionGroups: [size, milk, sweetness, extras])
    
    static let decaf = Drink(name: "Decaf Coffee",
                             drinkDescription: "Smooth and balanced with subtle notes of chocolate.",
                             image: #imageLiteral(resourceName: "decaf"),
                             optionGroups: [size, milk, sweetness])
    
    static let espresso = Drink(name: "Espresso",
                                drinkDescription: "Smooth and balanced.",
                                image: #imageLiteral(resourceName: "espresso"),
                                optionGroups: [size, milk, sweetness])
    
    static let icedCoffee = Drink(name: "Iced Coffee",
                                  drinkDescription: "A Blend of coffees from Colombia and East Africa.",
                                  image: #imageLiteral(resourceName: "iced_coffee"),
                                  optionGroups: [size, milk, sweetness, ice, extras])
    
    static let hotChocolate = Drink(name: "Hot Chocolate",
                                    drinkDescription: "Shaved chocolate, milk and sugar",
                                    image: #imageLiteral(resourceName: "hot_chocolate"),
                                    optionGroups: [size, milk, extras])
    
    static let blackTea = Drink(name: "Black Tea",
                                drinkDescription: "Bold flavor.",
                                image: #imageLiteral(resourceName: "black_tea"),
                                optionGroups: [size])
    
    // MARK: - Drink Option Groups
    
    static let size = DrinkOptionGroup(name: "Size", selectionType: .single, isRequired: true, options: [
        DrinkOption(name: "Small", price: 100),
        DrinkOption(name: "Medium", price: 200),
        DrinkOption(name: "Large", price: 300),
    ])
    
    static let milk = DrinkOptionGroup(name: "Milk", selectionType: .single, isRequired: true, options: [
        DrinkOption(name: "No Milk"),
        DrinkOption(name: "Whole Milk"),
        DrinkOption(name: "Soy Milk"),
        DrinkOption(name: "Almond Milk", price: 50)
    ])
    
    static let sweetness = DrinkOptionGroup(name: "Sweetness", selectionType: .single, isRequired: true, options: [
        DrinkOption(name: "No Sweetener"),
        DrinkOption(name: "Light"),
        DrinkOption(name: "Medium"),
        DrinkOption(name: "Extra")
    ])
    
    static let ice = DrinkOptionGroup(name: "Ice", selectionType: .single, isRequired: true, options: [
        DrinkOption(name: "Normal Ice"),
        DrinkOption(name: "Light Ice"),
        DrinkOption(name: "No Ice")
    ])
    
    static let extras = DrinkOptionGroup(name: "Extras", selectionType: .multiple, isRequired: false, options: [
        DrinkOption(name: "Turbo Shot", price: 50),
        DrinkOption(name: "Whipped Cream")
    ])
}

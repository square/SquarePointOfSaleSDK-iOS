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

/// UIView subclass for CustomizeDrinkViewController
final class CustomizeDrinkView: UIView {
    private(set) lazy var tableView: UITableView = self.makeTableView()
    private(set) lazy var headerView: CustomizeDrinkTableHeaderView = self.makeHeaderView()
    private(set) lazy var checkoutButton: CheckoutButton = self.makeCheckoutButton()
    private(set) lazy var cancelButton: UIButton = self.makeCancelButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Configure
    
    func configure(drink: Drink) {
        headerView.configure(title: drink.name, description: drink.drinkDescription, image: drink.image)
        headerView.frame.size.height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - Private
   
    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(tableView)
        addSubview(checkoutButton)
        addSubview(cancelButton)
        tableView.tableHeaderView = headerView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            checkoutButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            checkoutButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 72.0),
            
            cancelButton.topAnchor.constraint(equalTo: topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 80.0),
            cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor),
            
            headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
        ])
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.layoutMargins = UIEdgeInsets(top: 0.0, left: 100.0, bottom: 0.0, right: 100.0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 72.0
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.allowsMultipleSelection = true
        
        tableView.register(DrinkOptionCell.self, forCellReuseIdentifier: DrinkOptionCell.reuseIdentifier)
        tableView.register(CustomizeDrinkSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: CustomizeDrinkSectionHeaderView.reuseIdentifier)
        return tableView
    }
    
    private func makeHeaderView() -> CustomizeDrinkTableHeaderView {
        let view = CustomizeDrinkTableHeaderView()
        view.preservesSuperviewLayoutMargins = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func makeCheckoutButton() -> CheckoutButton {
        let button = CheckoutButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func makeCancelButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel"), for: [])
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

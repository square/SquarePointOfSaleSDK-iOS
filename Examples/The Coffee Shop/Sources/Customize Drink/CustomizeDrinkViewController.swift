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

protocol CustomizeDrinkViewControllerDelegate: class {
    /// Called when the customer taps the Check Out button after customizing their drink
    func customizeDrinkViewControllerDidFinish(with order: DrinkOrder)
    
    /// Called when the customer taps the cancel button
    func customizeDrinkViewControllerDidCancel()
}

/// Choose options to customize a drink. A table view section is added for each of the drink's DrinkOptionGroups.
final class CustomizeDrinkViewController: UIViewController, AlertShowing {
    fileprivate let drink: Drink
    weak var delegate: CustomizeDrinkViewControllerDelegate?
    
    fileprivate var customizeDrinkView: CustomizeDrinkView {
        // Cast self.view to our UIView subclass so we can access its properties
        return view as! CustomizeDrinkView
    }
    
    // MARK: - Init
    
    init(drink: Drink) {
        self.drink = drink
        super.init(nibName: nil, bundle: nil)
        setupPresentationStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CustomizeDrinkViewController must be initialized using `init(drink:)")
    }
    
    // MARK: - UIViewController Overrides
    
    override func loadView() {
        // Use a custom UIView subclass for self.view
        let view = CustomizeDrinkView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.checkoutButton.addTarget(self, action: #selector(checkoutButtonPressed), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeDrinkView.configure(drink: drink)
        preselectDefaultOptions()
        updateCheckoutButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customizeDrinkView.tableView.flashScrollIndicators()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Actions
    
    @objc private func checkoutButtonPressed() {
        delegate?.customizeDrinkViewControllerDidFinish(with: drinkOrder)
    }
    
    @objc private func cancelButtonPressed() {
        delegate?.customizeDrinkViewControllerDidCancel()
    }
}

// MARK: - Table View

extension CustomizeDrinkViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomizeDrinkSectionHeaderView.reuseIdentifier) as! CustomizeDrinkSectionHeaderView
        header.titleLabel.text = drink.optionGroups[section].name.uppercased()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return drink.optionGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drink.optionGroups[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let optionGroup = drink.optionGroups[indexPath.section]
        let option = optionGroup.options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkOptionCell.reuseIdentifier, for: indexPath) as! DrinkOptionCell
        cell.configure(option: option, isSingleSelect: optionGroup.selectionType == .single)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selectedIndexPaths = self.selectedIndexPaths(inSection: indexPath.section)
        let optionGroup = drink.optionGroups[indexPath.section]
        
        if case .single = optionGroup.selectionType, selectedIndexPaths.count == 1 {
            // We only allow one option in this group to be selected and a different row was already selected. Deselect this row and select the new one.
            tableView.deselectRow(at: selectedIndexPaths[0], animated: true)
            return indexPath
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCheckoutButton()
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let selectedIndexPaths = self.selectedIndexPaths(inSection: indexPath.section)
        let optionGroup = drink.optionGroups[indexPath.section]
        
        if optionGroup.isRequired && selectedIndexPaths.count == 1 {
            // The customer must select an option in this group so don't let them remove the only selection. They can instead tap a different option in the group to change their selection.
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCheckoutButton()
    }
}

// MARK: - Scroll View Delegate

extension CustomizeDrinkViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCancelButton()
        
        // Pass the scroll view offset to our header view so it can stretch when the customer scrolls past the top
        customizeDrinkView.headerView.configure(forScrollViewOffset: scrollView.contentOffset)
    }
    
    /// Change the cancelButton tint color based on scroll position
    private func updateCancelButton() {
        let cancelButtonY = customizeDrinkView.cancelButton.frame.midY
        let headerImageY = customizeDrinkView.convert(customizeDrinkView.headerView.imageView.frame, from: customizeDrinkView.headerView).maxY
        let cancelButtonIntersectsHeaderImage = headerImageY >= cancelButtonY
        customizeDrinkView.cancelButton.tintColor = cancelButtonIntersectsHeaderImage ? .white : Color.darkText
    }
}

// MARK: - Transitioning Delegate

extension CustomizeDrinkViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        // Use a custom presentation controller when showing the this screen
        return SheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - Private

fileprivate extension CustomizeDrinkViewController {
    
    /// Returns the current drink order with all selected options
    var drinkOrder: DrinkOrder {
        return DrinkOrder(drink: drink, options: selectedOptions)
    }
    
    func setupPresentationStyle() {
        // Use a custom presentation controller when showing this screen
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    func updateCheckoutButton() {
        // Display the total price on the checkout button
        let total = MoneyFormatter.string(for: drinkOrder.price)
        customizeDrinkView.checkoutButton.detailText = total
    }
    
    /// If an option group is required, select the first option by default
    func preselectDefaultOptions() {
        for (sectionIndex, optionGroup) in drink.optionGroups.enumerated()
            where optionGroup.isRequired && !optionGroup.options.isEmpty {
                
            let firstIndexPath = IndexPath(row: 0, section: sectionIndex)
            customizeDrinkView.tableView.selectRow(at: firstIndexPath, animated: true, scrollPosition: .none)
        }
    }
    
    /// Returns all selected options, regardless of the containing DrinkOptionGroup
    var selectedOptions: [DrinkOption] {
        return drink.optionGroups.enumerated().flatMap { section, optionGroup -> [DrinkOption] in
            selectedIndexPaths(inSection: section).map { indexPath in
                optionGroup.options[indexPath.row]
            }
        }
    }
    
    func selectedIndexPaths(inSection section: Int) -> [IndexPath] {
        let allSelectedIndexPaths = customizeDrinkView.tableView.indexPathsForSelectedRows
        return allSelectedIndexPaths?.filter({ $0.section == section }) ?? []
    }
}

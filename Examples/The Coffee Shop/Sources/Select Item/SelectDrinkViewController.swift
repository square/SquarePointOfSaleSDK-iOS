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

protocol SelectDrinkViewControllerDelegate: class {
    /// Called when the customer selects a drink
    func selectDrinkViewControllerDidSelect(_ drink: Drink)
}

/// Displays a grid of drinks which the user can choose from
final class SelectDrinkViewController: UICollectionViewController {
    private let drinks: [Drink]
    private let layout = SelectDrinkCollectionViewLayout()
    weak var delegate: SelectDrinkViewControllerDelegate?
    
    // MARK: - Init
    
    init(drinks: [Drink]) {
        self.drinks = drinks
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("SelectDrinkViewController must be initialized using `init(drinks:)")
    }
    
    // MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Set arbitrary size to show header. Header gets resized in `collectionView:viewForSupplementaryElementOfKind:at:`
         layout.headerReferenceSize = CGSize(width: 1, height: 1)
    }
    
    // MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCell.reuseIdentifier, for: indexPath) as! DrinkCell
        let drink = drinks[indexPath.item]
        cell.configure(with: drink)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drink = drinks[indexPath.item]
        delegate?.selectDrinkViewControllerDidSelect(drink)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else {
            fatalError("Supplementary element kind not supported: \(kind)")
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: SelectDrinkHeaderView.reuseIdentifier,
                                                                     for: indexPath) as! SelectDrinkHeaderView
        header.nameLabel.text = LocationName
        header.logoImageView.image = LocationLogoImage
        
        header.translatesAutoresizingMaskIntoConstraints = false
        header.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        layout.headerReferenceSize = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return header
    }
    
    // MARK: - Private
    
    private func setupCollectionView() {
        let backgroundView = UIImageView(image: LocationBackgroundImage)
        backgroundView.contentMode = .scaleAspectFill
        
        collectionView?.backgroundView = backgroundView
        collectionView?.register(DrinkCell.self, forCellWithReuseIdentifier: DrinkCell.reuseIdentifier)
        collectionView?.register(SelectDrinkHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SelectDrinkHeaderView.reuseIdentifier)
    }
}

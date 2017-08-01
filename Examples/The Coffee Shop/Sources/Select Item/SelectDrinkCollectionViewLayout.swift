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

/// Displays a grid of drink cells in SelectDrinkViewController
final class SelectDrinkCollectionViewLayout: UICollectionViewFlowLayout {
    private let numberOfItemsPerRow = 3
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        recalculateItemSize()
    }
    
    // MARK: - Private
    
    private func commonInit() {
        sectionInset = UIEdgeInsets(top: 32.0, left: 112.0, bottom: 32.0, right: 112.0)
        minimumInteritemSpacing = 40.0
        minimumLineSpacing = 40.0
    }
   
    private func recalculateItemSize() {
        let collectionViewBounds = collectionView?.bounds ?? .zero
        let sectionWidth = collectionViewBounds.insetBy(dx: sectionInset.left, dy: sectionInset.right).width
        let totalInteritemSpacing = CGFloat(numberOfItemsPerRow - 1) * minimumInteritemSpacing
        let cellWidth = (sectionWidth - totalInteritemSpacing) / CGFloat(numberOfItemsPerRow)
        itemSize = CGSize(width: cellWidth, height: cellWidth)
    }
}

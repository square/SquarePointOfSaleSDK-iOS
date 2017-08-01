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

/// Displays the name and image of a drink on the Select Drink screen
final class DrinkCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: DrinkCell.self)
    private(set) lazy var imageView: UIImageView = self.makeImageView()
    private(set) lazy var nameLabel: UILabel = self.makeLabel(color: Color.darkText)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configure(with drink: Drink) {
        nameLabel.text = drink.name
        imageView.image = drink.image
    }
    
    // MARK: - Private
    
    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.layoutMargins = UIEdgeInsets(top: 17.0, left: 20.0, bottom: 17.0, right: 20.0)
        contentView.backgroundColor = .white
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = Color.lightText
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func makeLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19.0, weight: UIFontWeightMedium)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

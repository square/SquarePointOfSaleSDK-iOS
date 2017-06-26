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

/// Displays the merchant's name and logo at the top of the Select Drink screen
final class SelectDrinkHeaderView: UICollectionReusableView {
    static let reuseIdentifier = String(describing: SelectDrinkHeaderView.self)
    private(set) lazy var logoImageView: UIImageView = self.makeImageView()
    private(set) lazy var nameLabel: UILabel = self.makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configure(title: String, image: UIImage) {
        logoImageView.image = image
        nameLabel.text = title
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - Private
   
    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 40.0, left: 32.0, bottom: 32.0, right: 32.0)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(logoImageView)
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: layoutMargins.top),
            logoImageView.widthAnchor.constraint(equalToConstant: 124.0),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            logoImageView.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor),
            logoImageView.leadingAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 26.0),
            nameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40.0, weight: UIFontWeightHeavy)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

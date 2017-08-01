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

/// A table header shown on the Customize Drink screen
final class CustomizeDrinkTableHeaderView: UIView {
    private(set) lazy var imageView: UIImageView = self.makeImageView()
    private(set) lazy var titleLabel: UILabel = self.makeTitleLabel()
    private(set) lazy var descriptionLabel: UILabel = self.makeDescriptionLabel()
    
    /// Container guide used to implement "stretchy" header when scrolling past top
    private(set) lazy var imageViewContainerGuide: UILayoutGuide = UILayoutGuide()
    
    private lazy var imageViewContainerTopConstraint: NSLayoutConstraint = self.imageView.topAnchor.constraint(equalTo: self.topAnchor)
    private lazy var imageViewContainerHeightConstraint: NSLayoutConstraint = self.imageView.heightAnchor.constraint(equalToConstant: self.imageHeight)
    
    private let imageHeight: CGFloat = 300.0
    
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
    
    func configure(title: String, description: String, image: UIImage) {
        titleLabel.text = title
        descriptionLabel.text = description
        imageView.image = image
    }
    
    func configure(forScrollViewOffset offset: CGPoint) {
        if offset.y >= 0.0 {
            imageViewContainerTopConstraint.constant = 0.0
            imageViewContainerHeightConstraint.constant = imageHeight
        }
        else {
            imageViewContainerHeightConstraint.constant = imageHeight + abs(offset.y)
            imageViewContainerTopConstraint.constant = offset.y
        }
    }
    
    // MARK: - Private
    
    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addLayoutGuide(imageViewContainerGuide)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageViewContainerTopConstraint,
            imageViewContainerHeightConstraint,
            
            imageView.topAnchor.constraint(equalTo: imageViewContainerGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainerGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageViewContainerGuide.bottomAnchor, constant: 38.0),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            ])
        titleLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
    }
    
    private func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let font = UIFont.systemFont(ofSize: 21.0, weight: UIFontWeightMedium)
        return makeLabel(font: font, color: Color.darkText)
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)
        return makeLabel(font: font, color: Color.lightText)
    }
    
    private func makeLabel(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = font
        label.textColor = color
        return label
    }
}

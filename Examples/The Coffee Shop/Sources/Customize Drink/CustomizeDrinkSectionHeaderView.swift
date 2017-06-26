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

/// A section header shown in the Customize Drink screen's table view
final class CustomizeDrinkSectionHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: CustomizeDrinkSectionHeaderView.self)
    private(set) lazy var titleLabel: UILabel = self.makeLabel()
    private lazy var separator: UIView = self.makeSeparator()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Private
    
    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 13.0, left: 13.0, bottom: 13.0, right: 13.0)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(separator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            separator.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            ])
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: UIFontWeightMedium)
        label.textColor = Color.lightText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = Color.separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

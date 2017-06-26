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

/// A UITableViewCell subclass used in CustomizeDrinkViewController
final class DrinkOptionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: DrinkOptionCell.self)
    private lazy var titleLabel: UILabel = self.makeLabel()
    private lazy var subtitleLabel: UILabel = self.makeLabel()
    private lazy var button: DrinkOptionCellButton = self.makeButton()
    private lazy var separator: UIView = self.makeSeparator()
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - UITableViewCell Overrides
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        button.selected = selected
    }
    
    // MARK: - Configure
    
    func configure(option: DrinkOption, isSingleSelect: Bool) {
        titleLabel.text = option.name
        subtitleLabel.text = option.price == 0 ? nil : MoneyFormatter.string(for: option.price)
        button.style = isSingleSelect ? .radio : .checkmark
    }
    
    // MARK: - Private
    
    private func commonInit() {
        contentView.layoutMargins = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 20.0)
        selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(button)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(separator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            separator.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
        ])
        subtitleLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: UIFontWeightRegular)
        label.textColor = Color.darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeButton() -> DrinkOptionCellButton {
        let view = DrinkOptionCellButton()
        view.tintColor = Color.darkText
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func makeSeparator() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.separator
        return view
    }
}

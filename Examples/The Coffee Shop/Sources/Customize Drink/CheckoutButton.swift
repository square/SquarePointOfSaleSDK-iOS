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

/// UIButton subclass shown on the Customize Drink screen. Displays a detail label on the right hand side.
final class CheckoutButton: UIButton {
    private lazy var detailLabel = UILabel()
    
    var detailText: String? {
        get {
            return detailLabel.text
        }
        set {
            detailLabel.text = newValue
            setNeedsLayout()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - UIView Overrides
   
    override func layoutSubviews() {
        super.layoutSubviews()
        detailLabel.frame = frameForDetailLabel
    }
    
    // MARK: - Private
    
    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 22.0, right: 24.0)
        backgroundColor = Color.buttonBackground
        setupTitleLabel()
        setupDetailLabel()
    }
    
    private func setupTitleLabel() {
        let attributedTitle = NSAttributedString(string: "Check Out", attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 21.0, weight: UIFontWeightMedium),
            NSForegroundColorAttributeName: UIColor.white
        ])
        setAttributedTitle(attributedTitle, for: [])
    }
    
    private func setupDetailLabel() {
        detailLabel.textAlignment = .right
        detailLabel.font = .systemFont(ofSize: 21.0, weight: UIFontWeightMedium)
        detailLabel.textColor = .white
        addSubview(detailLabel)
    }
    
    private var frameForDetailLabel: CGRect {
        let size = detailLabel.intrinsicContentSize
        let origin = CGPoint(x: bounds.maxX - layoutMargins.right - size.width,
                             y: bounds.midY - size.height / 2.0)
        return CGRect(origin: origin, size: size)
    }
}

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

/// Displays a radio button or checkmark. This "button" is not tappable. DrinkOptionCell updates the button state when a row is selected
final class DrinkOptionCellButton: UIView {
    enum Style {
        case checkmark, radio
    }
    
    // MARK: - Properties
    
    var lineWidth: CGFloat = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var style: Style = .checkmark {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var selected: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            setNeedsDisplay()
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
    
    private func commonInit() {
        isOpaque = false
    }
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        switch style {
        case .radio:
            drawRadio(in: rect)
        case .checkmark:
            drawCheckmark(in: rect)
        }
    }
    
    private func drawCheckmark(in rect: CGRect) {
        guard selected else {
            // Deselected checkmark style looks the same as deselected radio style
            drawRadio(in: rect)
            return
        }
        drawFill(in: rect)
        let image = #imageLiteral(resourceName: "checkmark")
        let imageOrigin = CGPoint(x: rect.midX - image.size.width / 2.0,
                                  y: rect.midY - image.size.height / 2.0)
        image.draw(at: imageOrigin)
    }
    
    private func drawRadio(in rect: CGRect) {
        let strokeRect = rect.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
        drawStroke(in: strokeRect)
        
        if selected {
            let fillRect = rect.insetBy(dx: lineWidth * 2.0, dy: lineWidth * 2.0)
            drawFill(in: fillRect)
        }
    }
    
    private func drawStroke(in rect: CGRect) {
        tintColor.setStroke()
        let path = UIBezierPath(ovalIn: rect)
        path.lineWidth = lineWidth
        path.stroke()
    }
    
    private func drawFill(in rect: CGRect) {
        tintColor.setFill()
        let path = UIBezierPath(ovalIn: rect)
        path.fill()
    }
}

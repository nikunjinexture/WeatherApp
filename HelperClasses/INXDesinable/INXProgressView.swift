//
//  INXProgressView.swift
//  INXHelperClaas
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import UIKit

@IBDesignable
class INXProgressView: UIView {

    fileprivate var shapeL:CAShapeLayer!
    fileprivate var path:UIBezierPath!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBInspectable var progress: CGFloat = 0

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        shapeL = CAShapeLayer()
        path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.size.width / 2, height: self.frame.size.height))

        shapeL.path = path.cgPath
        shapeL.fillColor = self.tintColor.cgColor
        self.layer.addSublayer(shapeL)
    }
    

}

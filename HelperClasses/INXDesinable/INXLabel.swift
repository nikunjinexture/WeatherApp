//
//  LetsLabel
//  LetsLabel
//
//  Created by Ketan Raval on 28/09/15.
//  Copyright (c) 2018 Helapay. All rights reserved.
//

import UIKit

@IBDesignable
class INXLabel : UILabel {
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear
        {
        didSet
        {
            layer.borderColor = borderColor.cgColor
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0
        {
        didSet
        {
            layer.borderWidth = borderWidth
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var isCircle: Bool = false
        {
        didSet
        {
            layer.cornerRadius = frame.width/2
            layer.masksToBounds = true
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet
        {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    @IBInspectable var fitToWidth: Bool = false
        {
        didSet
        {
            adjustsFontSizeToFitWidth = fitToWidth
        }
    }
    
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    override func drawText(in rect: CGRect)
    {
        let insets = UIEdgeInsets.init(top: 0, left: paddingLeft, bottom: 0, right: paddingRight)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        
    }
    @IBInspectable var topBorderColor : UIColor = UIColor.clear
    @IBInspectable var topBorderHeight : CGFloat = 0
        {
        didSet
        {
            if topBorder == nil
            {
                topBorder = UIView()
                addSubview(topBorder!)
            }
            topBorder?.backgroundColor = topBorderColor
            topBorder?.frame = CGRect(x: 0,y: 0,width: self.frame.size.width,height: topBorderHeight)
        }
    }
    @IBInspectable var bottomBorderColor : UIColor = UIColor.clear
    @IBInspectable var bottomBorderHeight : CGFloat = 0
        {
        didSet
        {
            if bottomBorder == nil
            {
                bottomBorder = UIView()
                addSubview(bottomBorder!)
            }
            bottomBorder?.backgroundColor = bottomBorderColor
            bottomBorder?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight,width: self.frame.size.width,height: bottomBorderHeight)
        }
    }
    @IBInspectable var leftBorderColor : UIColor = UIColor.clear
    @IBInspectable var leftBorderHeight : CGFloat = 0
        {
        didSet
        {
            if leftBorder == nil
            {
                leftBorder = UIView()
                addSubview(leftBorder!)
            }
            leftBorder?.backgroundColor = leftBorderColor
            leftBorder?.frame = CGRect(x: 0,y: 0,width: leftBorderHeight,height: self.frame.size.height)
        }
    }
    @IBInspectable var rightBorderColor : UIColor = UIColor.clear
    @IBInspectable var rightBorderHeight : CGFloat = 0
        {
        didSet
        {
            if rightBorder == nil
            {
                rightBorder = UIView()
                addSubview(rightBorder!)
            }
            rightBorder?.backgroundColor = rightBorderColor
            rightBorder?.frame = CGRect(x: self.frame.size.width - rightBorderHeight,y: 0,width: rightBorderHeight,height: self.frame.size.height)
        }
    }
    
    override func layoutSubviews() {
        
        topBorder?.frame = CGRect(x: 0,y: 0,width: self.frame.size.width,height: topBorderHeight)
        bottomBorder?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight ,width: self.frame.size.width,height: bottomBorderHeight)
        leftBorder?.frame = CGRect(x: 0,y: 0,width: leftBorderHeight,height: self.frame.size.height)
        rightBorder?.frame = CGRect(x: self.frame.size.width - rightBorderHeight,y: 0,width: rightBorderHeight,height: self.frame.size.height)
    }
    
    
}


@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}


//
//  LetsButton.swift
//  LetsButton
//
//  Created by Ketan Raval on 28/09/15.
//  Copyright (c) 2018 Helapay. All rights reserved.
//

import UIKit

@IBDesignable
class INXButton : UIButton {
    var topBorderView: UIView?
    var bottomBorderView: UIView?
    var leftBorderView: UIView?
    var rightBorderView: UIView?
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    @IBInspectable var progress: CGFloat = 0
    {
        didSet
        {
            if (progress > 1)
            {
                self.circlePathLayer?.strokeEnd = 1;
            }
            else if (progress <= 0)
            {
                self.circlePathLayer?.strokeEnd = 0;
            }
            else
            {
                //                circlePathLayer.removeFromSuperlayer()
                if self.circlePathLayer == nil
                {
                    self.circlePathLayer = CAShapeLayer()
                    self.circlePathLayer?.frame = CGRect(x: 2,y:  2,width: self.bounds.size.width - 4,height: self.bounds.size.height - 4)
                    self.circlePathLayer!.lineWidth = self.progressLineWidth
                    self.circlePathLayer!.fillColor = self.circleBackgroundColor.cgColor
                    self.circlePathLayer!.strokeColor = self.progressLineColor.cgColor
                    self.layer.addSublayer(self.circlePathLayer!)
                    self.layer.transform = CATransform3DMakeRotation(CGFloat(RADIANS(-90)), 0, 0, 1)
                }
                self.circlePathLayer?.strokeEnd = progress;
            }
        }
    }
    @IBInspectable var progressLineWidth: CGFloat = 0
    {
        didSet
        {
            self.circlePathLayer?.lineWidth = self.progressLineWidth
        }
    }
    @IBInspectable var progressLineColor : UIColor  = UIColor.clear
    {
        didSet
        {
            self.circlePathLayer?.strokeColor = self.progressLineColor.cgColor
        }
    }
    @IBInspectable var circleBackgroundColor : UIColor = UIColor.clear
    {
        didSet
        {
            self.circlePathLayer?.fillColor = self.circleBackgroundColor.cgColor
        }
    }
    var circlePathLayer : CAShapeLayer?
    func centerButtonAndImageWithSpacing(_ spacing: CGFloat)
    {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0)
    }
    @IBInspectable var isRightImage : Bool = false
    {
        didSet
        {
            if isRightImage
            {
                titleEdgeInsets = UIEdgeInsetsMake(0, (10 - imageView!.frame.size.width), 0, imageView!.frame.size.width)
                imageEdgeInsets = UIEdgeInsetsMake(0, frame.size.width - (10 + imageView!.frame.size.width), 0, 0)
                print(frame.size.width - (10 + imageView!.frame.size.width))
            }
        }
    }
    @IBInspectable var highlightedImage : UIImage?
    {
        didSet
        {
            setImage(highlightedImage, for: .highlighted)
        }
    }
    @IBInspectable var normalImage: UIImage?
    {
        didSet
        {
            setImage(normalImage, for: .normal)
        }
    }
    @IBInspectable var normalTextColor : UIColor?
    {
        didSet
        {
            setTitleColor(normalTextColor, for: .normal)
        }
    }
    @IBInspectable var highlightedTextColor : UIColor?
    {
        didSet
        {
            setTitleColor(highlightedTextColor, for: .highlighted)
        }
    }
    @IBInspectable var highlightedBackgroundColor: UIColor = UIColor.clear
    {
        didSet
        {
            setBackgroundImage(getImageWithColor(highlightedBackgroundColor, size: CGSize(width: 1, height: 1)), for: .highlighted)
        }
    }
    @IBInspectable var normalBackgroundColor: UIColor = UIColor.clear
    {
        didSet
        {
            setBackgroundImage(getImageWithColor(normalBackgroundColor, size:  CGSize(width: 1, height: 1)), for: .normal)
        }
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
    var section:Int = 0
    
    @IBInspectable var cornerRadius : CGFloat = 0
    {
        didSet
        {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    @IBInspectable var isCircle: Bool = false
    {
        didSet
        {
            layer.cornerRadius = frame.height/2
            layer.masksToBounds = true
        }
    }
    @IBInspectable var topBorderColor : UIColor = UIColor.clear
    @IBInspectable var topBorderHeight : CGFloat = 0
    {
        didSet
        {
            if topBorderView == nil
            {
                topBorderView = UIView()
                addSubview(topBorderView!)
            }
            topBorderView?.backgroundColor = topBorderColor
            topBorderView?.frame = CGRect(x: 0,y: 0,width: self.frame.size.width,height: topBorderHeight)
        }
    }
    @IBInspectable var bottomBorderColor : UIColor = UIColor.clear
    @IBInspectable var bottomBorderHeight : CGFloat = 0
    {
        didSet
        {
            if bottomBorderView == nil
            {
                bottomBorderView = UIView()
                addSubview(bottomBorderView!)
            }
            bottomBorderView?.backgroundColor = bottomBorderColor
            bottomBorderView?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight ,width: self.frame.size.width,height: bottomBorderHeight)
        }
    }
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        if isCircle
        {
            layer.cornerRadius = frame.height/2
            layer.masksToBounds = true
        }
        else
        {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
        if isRightImage
        {
            titleEdgeInsets = UIEdgeInsetsMake(0, (10 - imageView!.frame.size.width), 0, imageView!.frame.size.width)
            
            imageEdgeInsets = UIEdgeInsetsMake(0, frame.size.width - (10 + imageView!.frame.size.width), 0, 0)
        }
    }
    override func layoutSubviews()
    {
        super.layoutSubviews()
        if isRightImage
        {
            titleEdgeInsets = UIEdgeInsetsMake(0, (10 - imageView!.frame.size.width), 0, imageView!.frame.size.width)
           
            imageEdgeInsets = UIEdgeInsetsMake(0, frame.size.width - (10 + imageView!.frame.size.width), 0, 0)
        }
        bottomBorderView?.backgroundColor = bottomBorderColor
        bottomBorderView?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight ,width: self.frame.size.width,height: bottomBorderHeight)
        rightBorderView?.backgroundColor = rightBorderColor
        rightBorderView?.frame = CGRect(x: self.frame.size.width - rightBorderHeight,y: 0,width: rightBorderHeight,height: self.frame.size.height)
        if self.circlePathLayer != nil
        {
            self.circlePathLayer?.frame = CGRect(x: 2,y: 2,width: self.bounds.size.width - 4,height: self.bounds.size.height - 4)
            self.circlePathLayer?.path = UIBezierPath(ovalIn: self.circlePathLayer!.bounds).cgPath
        }
    }
    @IBInspectable var leftBorderColor : UIColor = UIColor.clear
    @IBInspectable var leftBorderHeight : CGFloat = 0
    {
        didSet
        {
            if leftBorderView == nil
            {
                leftBorderView = UIView()
                addSubview(leftBorderView!)
            }
            leftBorderView?.backgroundColor = leftBorderColor
            leftBorderView?.frame = CGRect(x: 0,y: 0,width: leftBorderHeight,height: self.frame.size.height)
        }
    }
    @IBInspectable var rightBorderColor : UIColor = UIColor.clear
    @IBInspectable var rightBorderHeight : CGFloat = 0
    {
        didSet
        {
            if rightBorderView == nil
            {
                rightBorderView = UIView()
                addSubview(rightBorderView!)
            }
            rightBorderView?.backgroundColor = rightBorderColor
            rightBorderView?.frame = CGRect(x: self.frame.size.width - rightBorderHeight,y: 0,width: rightBorderHeight,height: self.frame.size.height)
        }
    }

}

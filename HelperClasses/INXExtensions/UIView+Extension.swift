//
//  UIView+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//


import Foundation
import UIKit

enum NLInnerShadowDirection : Int {
    case none = 0
    case left = 1
    case right = 2
    case top = 3
    case bottom = 4
    case all = 5
}
// MARK: - UIView Extension -
extension UIView {
    func removeSubviews (){
        subviews.forEach({ $0.removeFromSuperview() })
    }
    func setConstraintConstant(_ constant: CGFloat, forAttribute attribute: NSLayoutAttribute) -> Bool {
        let constraint: NSLayoutConstraint? = self.constraintForAttribute(attribute)
        if constraint != nil {
            constraint!.constant = constant
            return true
        }
        else {
            self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant))
            return false
        }
    }
    
    func constraintConstantforAttribute(_ attribute: NSLayoutAttribute) -> CGFloat {
        let constraint: NSLayoutConstraint? = self.constraintForAttribute(attribute)
        if constraint != nil {
            return constraint!.constant
        }
        else {
            return nan("")
        }
    }
    
    func constraintForAttribute(_ attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        let predicate: NSPredicate = NSPredicate(format: "firstAttribute = %d && firstItem = %@", attribute.rawValue, self)
        var fillteredArray: [NSLayoutConstraint]? = (self.superview!.constraints as [NSObject] as NSArray).filtered(using: predicate) as? [NSLayoutConstraint]
        if fillteredArray!.count == 0 {
            return nil
        }
        else {
            return fillteredArray![0]
        }
    }
    
    func hideByHeight(_ hidden: Bool) {
        self.hideView(hidden, byAttribute: .height)
    }
    
    func hideByWidth(_ hidden: Bool) {
        self.hideView(hidden, byAttribute: .width)
    }
    
    func hideView(_ hidden: Bool, byAttribute attribute: NSLayoutAttribute) {
        if self.isHidden != hidden {
            let constraintConstant: CGFloat = self.constraintConstantforAttribute(attribute) 
            if hidden {
                if constraintConstant != 0{
                    self.alpha = constraintConstant
                }
                else {
                    let size: CGSize = self.getSize()
                    self.alpha = (attribute == .height) ? size.height : size.width
                }
                _ = self.setConstraintConstant(0, forAttribute: attribute)
                self.isHidden = true
            }
            else {
                if constraintConstant != 0 {
                    self.isHidden = false
                    _ = self.setConstraintConstant(self.alpha, forAttribute: attribute)
                    self.alpha = 1
                }
            }
        }
    }
    
    func getSize() -> CGSize {
        self.updateSizes()
        return CGSize(width: self.bounds.size.width,height: self.bounds.size.height)
    }
    
    func updateSizes() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func sizeToSubviews() {
        self.updateSizes()
        let fittingSize: CGSize = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        self.frame = CGRect(x: 0,y: 0,width: UIScreen.width,height: fittingSize.height)
    }
    class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }
    
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = fromNib(nibNameOrNil, type: T.self)
        return v!
    }
    
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    
    
    
    func removeInnerShadow() {
        for view in self.subviews {
            if (view.tag == 2639) {
                view.removeFromSuperview()
                break
            }
        }
    }
    
    func addInnerShadow() {
        let c = UIColor()
        let color = c.withAlphaComponent(0.5)
        
        self.addInnerShadowWithRadius(3.0, color: color, inDirection: NLInnerShadowDirection.all)
    }
    
    func addInnerShadowWithRadius(_ radius: CGFloat, andAlpha: CGFloat) {
        let c = UIColor()
        let color = c.withAlphaComponent(alpha)
        
        self.addInnerShadowWithRadius(radius, color: color, inDirection: NLInnerShadowDirection.all)
    }
    
    func addInnerShadowWithRadius(_ radius: CGFloat, andColor: UIColor) {
        self.addInnerShadowWithRadius(radius, color: andColor, inDirection: NLInnerShadowDirection.all)
    }
    
    func addInnerShadowWithRadius(_ radius: CGFloat, color: UIColor, inDirection: NLInnerShadowDirection) {
        self.removeInnerShadow()
        
        let shadowView = self.createShadowViewWithRadius(radius, andColor: color, direction: inDirection)
        shadowView.isUserInteractionEnabled = false
        self.addSubview(shadowView)
    }
    
    func createShadowViewWithRadius(_ radius: CGFloat, andColor: UIColor, direction: NLInnerShadowDirection) -> UIView {
        let shadowView = UIView(frame: CGRect(x: 0,y: 0,width: self.bounds.size.width,height: self.bounds.size.height))
        shadowView.backgroundColor = UIColor.clear
        shadowView.tag = 2639
        
        let colorsArray: Array = [ andColor.cgColor, UIColor.clear.cgColor ]
        
        if direction == .top {
            let xOffset: CGFloat = 0.0
            let topWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPoint(x: 0.5,y: 0.0)
            shadow.endPoint = CGPoint(x: 0.5,y: 1.0)
            shadow.frame = CGRect(x: xOffset,y: 0,width: topWidth,height: radius)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction == .bottom {
            let xOffset: CGFloat = 0.0
            let bottomWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPoint(x: 0.5,y: 1.0)
            shadow.endPoint = CGPoint(x: 0.5,y: 0.0)
            shadow.frame = CGRect(x: xOffset,y: self.bounds.size.height - radius,width: bottomWidth,height: radius)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction == .left {
            let yOffset: CGFloat = 0.0
            let leftHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRect(x: 0,y: yOffset,width: radius,height: leftHeight)
            shadow.startPoint = CGPoint(x: 0.0,y: 0.5)
            shadow.endPoint = CGPoint(x: 1.0,y: 0.5)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction == .right {
            let yOffset: CGFloat = 0.0
            let rightHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRect(x: self.bounds.size.width - radius,y: yOffset,width: radius,height: rightHeight)
            shadow.startPoint = CGPoint(x: 1.0,y: 0.5)
            shadow.endPoint = CGPoint(x: 0.0,y: 0.5)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        return shadowView
    }
    func addshadow () {
        layer.cornerRadius = 0
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.5,height: -0.5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
    }
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func screenshot() -> UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        }
    }
    
   
}

//
//  UIViewExtension.swift
//  MyDataManager
//
//  Created by Tung Nguyen on 1/24/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import UIKit
private var kViewGradientLayer: UInt8 = 0
extension UIView {
    var gradientLayer: CAGradientLayer? {
        get {
            return objc_getAssociatedObject(self, &kViewGradientLayer) as? CAGradientLayer
        }
        set {
            objc_setAssociatedObject(self, &kViewGradientLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func imageSnapshot() -> UIImage? {
        if let first = subviews.first, first.isKind(of: UIScrollView.self) {
            return scrollviewSnapShot(scrollView: first as! UIScrollView, frame: bounds)
        }
        return imageSnapshotCroppedToFrame()
    }
    
    func imageSnapshotCroppedToFrame(frame: CGRect = .zero) -> UIImage? {
        let scaleFactor = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scaleFactor)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let imageContext: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard var image = imageContext else {return nil}
        
        if !frame.equalTo(CGRect.zero) {
            let scaledRect = frame.applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
            
            if let imageRef = image.cgImage!.cropping(to: scaledRect) {
                image = UIImage(cgImage: imageRef)
            }
        }
        return image
    }
    
    func scrollviewSnapShot(scrollView: UIScrollView, frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
                let offset = scrollView.contentOffset
                let thisContext = UIGraphicsGetCurrentContext()
                thisContext?.translateBy(x: -offset.x, y: -offset.y)
                scrollView.layer.render(in: thisContext!)
                let visibleScrollViewImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
        return visibleScrollViewImage
    }
    
    static func makeFromXib<T: UIView>(_ type: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
    
    func roundCorners(_ radius: CGFloat, corners: UIRectCorner = .allCorners) {
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        mask.frame = bounds
        layer.mask = mask
    }
    
    func round(_ radius: CGFloat, color: UIColor = .clear, width: CGFloat = 0) {
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.masksToBounds = true
    }
    
    func shadow(_ radius: CGFloat, color: UIColor, opacity: Float = 0.5, offset: CGSize = .zero) {
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
    }
    
    func transitionFlash(_ animation: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: animation, completion: completion)
    }
    
    func applyGradient(with colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(with colours: [UIColor], gradient orientation: GradientOrientation) {
        layoutIfNeeded()
        DispatchQueue.main.async {
            if self.gradientLayer == nil {
                self.gradientLayer = CAGradientLayer()
            }
            self.gradientLayer?.removeFromSuperlayer()
            self.gradientLayer!.frame = self.bounds
            self.gradientLayer!.colors = colours.map { $0.cgColor }
            self.gradientLayer!.startPoint = orientation.startPoint
            self.gradientLayer!.endPoint = orientation.endPoint
            self.layer.insertSublayer(self.gradientLayer!, at: 0)
        }
    }
    
    func removeGradient() {
        if let gradientLayer = gradientLayer {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func sizeToFitCustom () -> CGSize {
        var size = CGSize(width: 0, height: 0)
        for view in self.subviews {
            let frame = view.frame
            let newW = frame.origin.x + frame.width
            let newH = frame.origin.y + frame.height
            if newW > size.width {
                size.width = newW
            }
            if newH > size.height {
                size.height = newH
            }
        }
        self.frame.size = size
        return size
    }
    
    func addbackgroundBlurView(style: UIBlurEffect.Style = .light, alpha: CGFloat = 1) {
        if !UIAccessibility.isReduceTransparencyEnabled {
//            self.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.alpha = alpha
            //always fill the view
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.insertSubview(blurEffectView, at: 0)
        }
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, color: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4884042298)) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 0.7
        shapeLayer.lineDashPattern = [3, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
            
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}

extension UIView {
    func convertCenter(to view: UIView) -> CGPoint {
        guard let superView = superview else {return center}
        return superView.convert(center, to: view)
    }
    
    func convertRect(to view: UIView) -> CGRect {
        guard let superView = superview else {return frame}
        return superView.convert(frame, to: view)
    }
    
    func disable() {
        alpha = 0.5
        isUserInteractionEnabled = false
    }
    
    func enable() {
        alpha = 1
        isUserInteractionEnabled = true
    }
    
    static func distance(_ delta: CGFloat, vertically: Bool = true) -> UIView {
        let v = UIView()
        v.backgroundColor = .clear
        return vertically ? v.setHeight(delta) : v.setWidth(delta)
    }
}

var kLoadingIndicatorView: UInt8 = 0
extension UIView {
    var loadingIndicator: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &kLoadingIndicatorView) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &kLoadingIndicatorView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func loading(_ isLoading: Bool, color: UIColor = .darkGray) {
        if isLoading {
            if loadingIndicator == nil {
                loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
                loadingIndicator?.hidesWhenStopped = true
                loadingIndicator?.backgroundColor = .clear
                addSubview(loadingIndicator!)
                loadingIndicator?.setCenterX(0, relativeToView: self)
                    .setCenterY(0, relativeToView: self)
            }
            bringSubviewToFront(loadingIndicator!)
            isUserInteractionEnabled = false
            loadingIndicator?.color = color
            loadingIndicator?.startAnimating()
        } else {
            isUserInteractionEnabled = true
            loadingIndicator?.stopAnimating()
        }
    }
}

extension UIView {
    var insetArea: UIEdgeInsets {
        let insets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            insets = self.safeAreaInsets
        }
        else {
            insets = UIEdgeInsets.zero
        }
        return insets
    }
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGesture(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        }
        else {}
    }
}


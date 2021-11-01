//
//  ProgessBar.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class ProgressBar: UIView {
    @IBInspectable var percent: CGFloat = 25 {
        didSet {
            redraw()
        }
    }
    
    @IBInspectable var progressColor: UIColor = #colorLiteral(red: 0.4509803922, green: 0.7921568627, blue: 0.1882352941, alpha: 0.3613836023)
    @IBInspectable var progressBackgroundColor = UIColor.white
    @IBInspectable var progressHeight: CGFloat = 10
    private var progressLayer = CAShapeLayer()
    private var progressBackgroundLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
//        layer.addSublayer(progressBackgroundLayer)
        layer.addSublayer(progressLayer)
        progressLayer.frame = CGRect(x: 0, y:frame.height / 2 - progressHeight / 2, width: rect.width * percent / 100, height: progressHeight)
        progressBackgroundLayer.frame = CGRect(x: 0, y:frame.height / 2 - progressHeight / 2, width: rect.width, height: progressHeight)
        drawLine()
//        drawProgressBackground()
    }
    
    private func redraw() {
        drawLine()
    }
    
    private func drawLine() {
        let progressFrame =  CGRect(x: 0, y:frame.height / 2 - progressHeight / 2, width: frame.width * percent / 100, height: progressHeight)
        let path = UIBezierPath(roundedRect: progressFrame, cornerRadius: progressFrame.height / 2)
        progressColor.setStroke()
        path.stroke()
        
        let linePath = UIBezierPath(roundedRect: CGRect(x: progressFrame.width - 2, y: 0, width: 2, height: progressFrame.height), cornerRadius: frame.height / 2)
        UIColor.red.setFill()
        linePath.fill()
        let mutilPath = CGMutablePath()
        mutilPath.addPath(path.cgPath)
        mutilPath.addPath(linePath.cgPath)
        mutilPath.closeSubpath()
        path.append(linePath)
        progressLayer.fillColor = progressColor.cgColor
        progressLayer.path = path.cgPath
        
    }
    
    private func drawProgressBackground() {
        let path = UIBezierPath(roundedRect: progressBackgroundLayer.frame, cornerRadius: progressBackgroundLayer.frame.height / 2)
        progressLayer.fillColor = progressBackgroundColor.cgColor
        progressLayer.path = path.cgPath
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        round(frame.height / 2)
    }
}

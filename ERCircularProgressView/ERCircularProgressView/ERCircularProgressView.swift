//
//  ERCircularProgressView.swift
//  ERCircularProgressView
//
//  Created by Mahmudul Hasan on 10/21/21.
//

import UIKit

class ERCircularProgressView: UIView {
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    //MARK: Public
    public var foregroundLineWidth:CGFloat = 50 {
        didSet{
            foregroundLayer.lineWidth = foregroundLineWidth
        }
    }
    
    public var backgroundLineWidth:CGFloat = 50 {
        didSet{
            backgroundLayer.lineWidth = foregroundLineWidth
        }
    }
    
    public var labelFont: UIFont = UIFont.boldSystemFont(ofSize: 35) {
        didSet {
            label.font = labelFont
            configLabel()
        }
    }
    
    public var labelTextColor: UIColor = .gray {
        didSet {
            label.textColor = labelTextColor
        }
    }
    
    public var safePercent: Int = 100 {
        didSet{
            setForegroundLayerColorForSafePercent()
        }
    }
    
    public var wholeCircleAnimationDuration: Double = 2
    public var backgroundLineColor: UIColor = .gray
    public var foregroundLineColor: UIColor = .red
    public var lineFinishColor: UIColor = .green
    
    public func setProgress(to progressConstant: Double) {
        
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        
        foregroundLayer.strokeEnd = CGFloat(progressConstant)
        self.label.text = "\(Int(progressConstant * 100))%"
        self.setForegroundLayerColorForSafePercent()
        self.configLabel()
    }

    //MARK: Private
    private var initialText = "0%"
    private var label = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - foregroundLineWidth)/2 }
            else { return (self.frame.height - foregroundLineWidth)/2 }
        }
    }
    
    private var pathCenter: CGPoint{
        get{ return self.convert(self.center, from:self.superview) }
    }
    
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = backgroundLineColor.cgColor
        self.backgroundLayer.lineWidth = backgroundLineWidth
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
    }
    
    private func drawForegroundLayer(){
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = CAShapeLayerLineCap.butt
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = foregroundLineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = foregroundLineColor.cgColor
        foregroundLayer.strokeEnd = 0
        
        self.layer.addSublayer(foregroundLayer)
    }
    
    private func makeLabel() {
        label.text = initialText
        label.textColor = labelTextColor
        label.font = labelFont
        label.sizeToFit()
        label.center = pathCenter
        self.addSubview(label)
    }
    
    private func configLabel(){
        label.sizeToFit()
        label.center = pathCenter
    }
    
    private func setForegroundLayerColorForSafePercent() {
        if let number = label.text!.parseToInt() {
            if number >= self.safePercent {
                self.foregroundLayer.strokeColor = lineFinishColor.cgColor
            } else {
                self.foregroundLayer.strokeColor = foregroundLineColor.cgColor
            }
        }
    }
    
    private func setupView() {
        makeBar()
        makeLabel()
    }
}

extension String {
    func parseToInt() -> Int? {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}


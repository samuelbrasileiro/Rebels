//
//  Pontuation.swift
//  Rebels
//
//  Created by Samuel on 11/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class Ring: UIView{
    func draw(color: UIColor){
        let halfSize:CGFloat = bounds.size.height/2
        let desiredLineWidth:CGFloat = 1    // your desired value
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        shapeLayer.lineWidth = desiredLineWidth
        
        layer.addSublayer(shapeLayer)
    }
    
    
}
class Pontuation: UIView{
    
    init(colorArray: [UIColor]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        for x in 0..<5{
            var i = CGFloat(x * 20)
            
            if i != 0 {i += (5 * CGFloat(x))}
            let view = Ring(frame: CGRect(x: i, y: 0, width: 20, height: 20))
            view.draw(color: colorArray[x])
            self.addSubview(view)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

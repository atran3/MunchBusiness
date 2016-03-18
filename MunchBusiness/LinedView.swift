//
//  LinedView.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/18/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import UIKit

class LinedView: UIView {
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let width: CGFloat = 1.0
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0.0, y: self.bounds.maxY - width))
        path.addLineToPoint(CGPoint(x: self.bounds.maxX, y: self.bounds.maxY - width))
        path.lineWidth = width
        let strokeColor = Util.Colors.DarkGray
        strokeColor.setStroke()
        path.stroke()
    }
}

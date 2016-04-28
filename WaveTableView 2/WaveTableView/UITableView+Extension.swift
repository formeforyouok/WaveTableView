
//
//  UITableView+Extension.swift
//  mybesti
//
//  Created by ZhanHao on 16/4/28.
//  Copyright © 2016年 zhanhao. All rights reserved.
//

import UIKit

public let bounceDistance : CGFloat = 4.0
public let waveDuration : CGFloat = 1.0

enum WaveAnimation : Int {
    case LeftToRightWaveAnimation = -1
    case RightToLeftWaveAnimation = 1
}

extension UITableView {
    
    func reloadDataAnimate(animation:WaveAnimation) {
        
        self.setContentOffset(self.contentOffset, animated: false)
        
        self.classForCoder.cancelPreviousPerformRequestsWithTarget(self)
        
        UIView.transitionWithView(self, duration: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { 
            self.hidden = true
            self.reloadData()
            }) { (finished) in
                
                self.hidden = false
                self.visibleRowsBeginAnimation(animation)
        }
    }
    
    func visibleRowsBeginAnimation(animation:WaveAnimation) {
    
        let array = self.indexPathsForVisibleRows
        for i in 0 ..< array!.count {
            let path = array![i] 
            let cell = self.cellForRowAtIndexPath(path)
            cell!.frame = self.rectForRowAtIndexPath(path)
            cell!.hidden = true
            cell?.layer.removeAllAnimations()
            let arr = [path,NSNumber(long : animation.rawValue)] 
            self.performSelector(#selector(UITableView.animationStart(_:)), withObject: arr, afterDelay: (0.08 * Double(i)))
        }
    }
    
    func animationStart(array:NSArray) {
        
        let path = array[0]
        let index = array[1] as! NSNumber
        let i : Float = index.floatValue
        let cell = self.cellForRowAtIndexPath(path as! NSIndexPath)
        let orginPoint = cell!.center 
        let beginPoint = CGPointMake(cell!.frame.size.width * CGFloat(i), orginPoint.y)
        let endBonce1Point = CGPointMake(orginPoint.x - CGFloat(i) * 2 * bounceDistance, orginPoint.y)
        let endBonce2Point = CGPointMake(orginPoint.x + CGFloat(i) * bounceDistance, orginPoint.y)
        cell!.hidden = false
        
        let move = CAKeyframeAnimation(keyPath: "position")
        move.keyTimes = [NSNumber(float:0.0),NSNumber(float:0.8),NSNumber(float:0.9),NSNumber(float:1.0)]
        move.values = [NSValue(CGPoint: beginPoint),NSValue(CGPoint: endBonce1Point),NSValue(CGPoint: endBonce2Point),NSValue(CGPoint: orginPoint)]
        move.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let opaAnimation = CABasicAnimation(keyPath: "opacity")
        opaAnimation.fromValue = 0.0
        opaAnimation.toValue = 1.0
        opaAnimation.autoreverses = false
        
        let group = CAAnimationGroup()
        group.animations = [move,opaAnimation]
        group.duration = Double(waveDuration)
        group.removedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        
        cell?.layer.addAnimation(group, forKey: nil)
        
    }
    
}

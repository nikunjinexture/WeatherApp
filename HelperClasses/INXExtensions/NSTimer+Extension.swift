//
//  NSTimer+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation

// MARK: - NSTimer Extension -
extension Timer
{
    class func scheduledTimerWithTimeInterval(_ timeInterval : TimeInterval, callback : @escaping TimerTickClosure) -> Timer
    {
        let block : @convention(block) (Timer) -> Void = callback
        let anyobject : AnyObject = unsafeBitCast(block , to: AnyObject.self)
        let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Timer.tick(_:)), userInfo:anyobject as AnyObject , repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        return timer
    }
    @objc class func tick(_ timer : Timer)
    {
        guard let userInfo = timer.userInfo else {return}
        let block : TimerTickClosure = unsafeBitCast(userInfo, to: TimerTickBlock.self)
        block(timer)
    }
}


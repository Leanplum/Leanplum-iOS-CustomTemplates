//
//  AlertWith3Buttons.swift
//  CustomTemplates
//
//  Created by Leanplum on 9.04.20.
//  Copyright © 2020 Leanplum. All rights reserved.
//

import UIKit
import Leanplum

//#### example Custom template for 3-button Alert
class AlertWith3Buttons {
    // MARK: Arguments
    static let Name = "3-button Alert"
    
    static let TitleArg = "Title"
    static let MessageArg = "Message"
    static let LaterArg = "Ask Me Later"
    static let AcceptActionArg = "Accept action"
    static let CancelActionArg = "Cancel action"
    static let LaterActionArg = "Ask Me Later action"
    
    static let AcceptStr = "Accept"
    static let CancelStr = "Cancel"
    
    static let TitleVal = "My title"
    static let MessageVal = "My default message"
    static let LaterVal = "Ask Me Later"
    
    // MARK: Definition
    static func defineAction() {
        //#### example Define message responder, executed when the message is shown
        let messageResponder: LeanplumActionBlock = { (context: ActionContext) in
            //#### example Present the in-app message in the desired way
            //#### example Dispalying simple Alert view with 3 buttons over top view controller
            if var topController: UIViewController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(AlertWith3Buttons.viewController(with: context), animated: true, completion: nil)
                return true
            }
            return false
        }
        
        //#### example Call to Leanplum.defineAction
        Leanplum.defineAction(name: Name,
                              kind:  .message,
                              //#### example Define the arguments for the template, configurable from the Dashboard
                              args: [
                                ActionArg.init(name: TitleArg, string: TitleVal),
                                ActionArg.init(name: MessageArg, string: MessageVal),
                                ActionArg.init(name: AcceptStr, string: AcceptStr),
                                ActionArg.init(name: CancelStr, string: CancelStr),
                                ActionArg.init(name: LaterArg, string: LaterVal),
                                ActionArg.init(name: AcceptActionArg, action: nil),
                                ActionArg.init(name: CancelActionArg, action: nil),
                                ActionArg.init(name: LaterActionArg, action: nil)],
                              completion: messageResponder)
    }
    
    // MARK: Presentation
    private static func viewController(with context: ActionContext) -> UIViewController {
        //#### example Extract values from the message context using the argument names defined
        //#### example The values in the context are those defined in the Dashboard or default values
        let alert = UIAlertController.init(title: NSLocalizedString(context.string(name: TitleArg) ?? TitleVal, comment: ""), message: NSLocalizedString(context.string(name: MessageArg) ?? MessageVal, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: NSLocalizedString(context.string(name: CancelStr) ?? CancelStr, comment: ""), style: .cancel) { (action) in
            //#### Executes the Cancel action, does not track an event
            context.runAction(name: CancelActionArg)
        }
        alert.addAction(cancel)
        let accept = UIAlertAction.init(title: NSLocalizedString(context.string(name: AcceptStr) ?? AcceptStr, comment: ""), style: .default) { (action) in
            //#### Executes the Accept action and tracks the event
            context.runTrackedAction(name: AcceptActionArg)
        }
        alert.addAction(accept)
        let maybe = UIAlertAction.init(title: NSLocalizedString(context.string(name: LaterArg) ?? LaterVal, comment: ""), style: .default) { (action) in
            //#### Executes the Maybe action and tracks the event
            context.runTrackedAction(name: LaterActionArg)
        }
        alert.addAction(maybe)
        
        return alert
    }
}

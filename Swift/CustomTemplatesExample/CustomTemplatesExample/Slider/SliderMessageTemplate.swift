//
//  SliderMessageTemplate.swift
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 6.10.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

import Leanplum

class SliderMessageTemplate {
    
    // MARK: Arguments
    static let Name = "Slider"
    static let TitleColorArg = "Title Color"
    static let TitlesArg = "Titles"
    static let ImagesArg = "Images"
    
    static let StoryboardName = "SliderMessageTemplateStoryboard"
    static let SliderViewControllerName = "SliderViewController"
    
    // MARK: Definition
    static func defineAction() {
        let messageResponder: LeanplumActionBlock = { (context: ActionContext) in
            var topController = UIApplication.shared.keyWindow!.rootViewController
            while (topController?.presentedViewController != nil) {
                topController = topController?.presentedViewController;
            }
            topController?.present(SliderMessageTemplate.viewControllerWithContext(with: context), animated: true, completion: nil)
            return true
        };
        
        let titles = ["Personalize every message", "Mobile App & Website Inbox Messages"]
        
        var dict:Dictionary = Dictionary<String, Any>.init()
        for i in 0...titles.count - 1 {
            let key = "Title \(i + 1)"
            dict[key] = titles[i]
        }
        
        Leanplum.defineAction(name: SliderMessageTemplate.Name, kind: .message,
                              args: [ActionArg.init(name: SliderMessageTemplate.TitleColorArg, color: UIColor.blue),
                                     ActionArg.init(name: SliderMessageTemplate.TitlesArg, dictionary: dict),
                                     ActionArg.init(name: SliderMessageTemplate.ImagesArg, dictionary: [:])],
                              completion: messageResponder)
    }
    
    // MARK: Presentation
    static func viewControllerWithContext(with context: ActionContext) -> UIViewController {
        let bundle = Bundle.init(for: SliderViewController.self)
        let storyboard = UIStoryboard.init(name: StoryboardName, bundle: bundle)
        let vcs = storyboard.instantiateViewController(withIdentifier: SliderViewControllerName)
        let vc = vcs as! SliderViewController
        vc.modalPresentationStyle = .fullScreen
        
        let titlesDict = context.dictionary(name: TitlesArg) as! [String:Any]
        let imagesDict = context.dictionary(name: ImagesArg) as! [String:Any]
        
        let titles = titlesDict.keys.sorted().compactMap{ titlesDict[$0] } as! [String]
        let images = imagesDict.keys.sorted().compactMap{ imagesDict[$0] } as! [String]
        
        vc.slideTitles = titles
        vc.slideImages = images
        vc.slideTitleColor = context.color(name: TitleColorArg)
        
        return vc
    }
}

//
//  SliderViewController.swift
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 6.10.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

import UIKit

class SliderViewController: ViewController, UIPageViewControllerDataSource {
    
    static let SlideViewControllerName = "SlideViewController"
    static let PageViewControllerName = "PageViewController"
    
    var slidesCount = 0
    var slideImages:[String] = []
    var slideTitles:[String] = []
    var pageViewController:UIPageViewController?
    var slideTitleColor:UIColor?
    
    @IBOutlet weak var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slidesCount = self.slideTitles.count > self.slideImages.count ? self.slideTitles.count : self.slideImages.count
        
        configureCloseButton()
        configurePageControl()
        
        configurePageViewController()
    }
    
    func configureCloseButton() {
        self.closeBtn.layer.cornerRadius = self.closeBtn.frame.size.height / 2
        self.closeBtn.clipsToBounds = true
        self.closeBtn.backgroundColor = UIColor.lightGray
        self.closeBtn.setTitleColor(UIColor.white, for: .normal)
        
        self.closeBtn.addTarget(self, action:#selector(closeButtonAction), for: .touchUpInside)
    }
    
    func configurePageControl() {
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.gray
    }
    
    @objc func closeButtonAction(sender: Any) {
        if let nav = self.navigationController {
            nav.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Page View Controller
    func configurePageViewController() {
        self.pageViewController = self.storyboard!.instantiateViewController(withIdentifier: SliderViewController.PageViewControllerName) as? UIPageViewController
        
        if let pageVc = pageViewController {
            let startingViewController = self.viewControllerAtIndex(index: 0)
            let viewControllers = [startingViewController] as? [UIViewController]
            pageVc.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
            
            // Change the size of page view controller
            pageVc.view.frame = CGRect.init(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height - 30)
            
            self.addChild(pageViewController!)
            //        [self.view addSubview:_pageViewController.view]
            self.view.insertSubview(pageVc.view, at: 0)
            pageVc.didMove(toParent: self)
            
            pageVc.dataSource = self
        }
    }
    
    // MARK: Page View Controller Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = (viewController as! SlideViewController).pageIndex
        
        if var index = currentIndex, index != 0 {
            index+=1
            if (index == self.slidesCount) {
                return nil
            }
            return self.viewControllerAtIndex(index: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = (viewController as! SlideViewController).pageIndex
        
        if var index = currentIndex {
            index+=1
            if (index == self.slidesCount) {
                return nil
            }
            return self.viewControllerAtIndex(index: index)
        }
        return nil
    }
    
    func viewControllerAtIndex(index: Int) -> SlideViewController? {
        if ((self.slidesCount == 0) || (index >= self.slidesCount)) {
            return nil
        }
        
        let singleSlideViewController = self.storyboard?.instantiateViewController(withIdentifier: SliderViewController.SlideViewControllerName) as! SlideViewController
        
        if self.slideTitles.count >= index + 1 {
            singleSlideViewController.titleText = self.slideTitles[index]
        }
        
        if self.slideImages.count >= index + 1 {
            singleSlideViewController.imageName = self.slideImages[index] as String
        }
        
        singleSlideViewController.titleColor = self.slideTitleColor
        singleSlideViewController.pageIndex = index
        
        return singleSlideViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.slidesCount
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

//
//  PagingViewControoller.swift
//  IQ
//
//  Created by Rath! on 1/2/24.
//

import UIKit

class PagingViewControoller: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    var obserIndex: ((_ index: Int)->())?
    
    private var pendingPage : Int = 0
    
    var pageViewController = UIPageViewController ()
    var contentViewController: [UIViewController] = []
    private var index: Int = 0
    var changeControllerIndex: Int = 0{
        didSet{
            DispatchQueue.main.async { [self] in
                
                if index < changeControllerIndex{
                    
                    pageViewController.setViewControllers([contentViewController[changeControllerIndex]],
                                                          direction: .forward,
                                                          animated: true,
                                                          completion: nil)
                    
                }else{
                    pageViewController.setViewControllers([contentViewController[changeControllerIndex]],
                                                          direction: .reverse,
                                                          animated: true,
                                                          completion: nil)
                }
                
                index = changeControllerIndex
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        
        
        
        
        //MARK: didsable scroll pagingView
        //                pageViewController.delegate = self
        //                pageViewController.dataSource = self
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll  , navigationOrientation: .horizontal, options: nil)
        // Add the page view controller to the view hierarchy
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([contentViewController[index]], direction: .forward, animated: true, completion: nil)
    }
    // Add view controllers to the contentViewController array
    func addContentViewController(viewController: UIViewController) {
        contentViewController.append(viewController)
    }
}


extension PagingViewControoller{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = contentViewController.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return contentViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = contentViewController.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        
        // Check if the next index is within bounds
        guard nextIndex < contentViewController.count else {
            return nil
        }
        
        return contentViewController[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        

        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = contentViewController.firstIndex(of: currentViewController) {
                obserIndex?(index)
            }
        }
    }
}

//
//  ViewController.swift
//  Trump Block
//
//  Created by Alex Meyer on 10/12/15.
//
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource
{
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    // MARK: - View Lifecyle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.pageTitles = NSArray(objects:
            "If you are ever tempted by the headlines..",
            "You may need a break from the mainstream media.",
            "To enable MSM Blocker\nin Safari's settings.\nGo to Settings > Safari > Content Blockers",
            "Now biased and slanted media content is blocked, and a zen blank page\nis loaded in its place.",
            "That's it! No more political fawning and misinformation.")
        self.pageImages = NSArray(objects: "new-page", "media-page", "settings-page","blank-page","page5")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startViewController = self.viewControllerAtIndex(0) as PageContentViewController
        let viewControllers = NSArray(object: startViewController)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.height - 30)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController
    {
        let viewController: PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        viewController.imageName = self.pageImages[index] as! String
        viewController.titleText = self.pageTitles[index] as! String
        viewController.pageIndex = index
        
        return viewController
    }
    
    // MARK - PageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if ((index == NSNotFound)) {
            return nil
        }
        
        index++
        if (index == self.pageTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
}


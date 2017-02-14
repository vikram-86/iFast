//
//  OnboardingViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController{

  lazy var orderedViewController: [OnboardingSceneViewController] = {
    let page1 = self.createViewController(backgroundImage: #imageLiteral(resourceName: "intro_1"),
                                     text: "iFast keeps track on your intermittent fasting window, so you don’t have to worry about it.",
                                     page: 0)
    let page2 = self.createViewController(backgroundImage: #imageLiteral(resourceName: "intro_2"),
                                     text: "iFast lets you see your progress with charts and pictures. Everytthing is locally stored.",
                                     page: 1)
    let page3 = self.createViewController(backgroundImage: #imageLiteral(resourceName: "intro_3"), text: "Let iFast help you by enabling notification.\n\nBy enabling notifications, iFast will notify your 1 hour before your fast begins.", page: 2)
    let page4 = self.createViewController(backgroundImage: #imageLiteral(resourceName: "intro_4"),
                                          text: "Always consult your physician before beginning any diet program. This general information is not intended to diagnose any medical condition or to replace your healthcare professional. Consult with your healthcare professional to design an appropriate diet prescription. If you experience any pain or difficulty with this program, stop and consult your healthcare provider",
                                          isLast: true, page: 3)
    return [page1, page2, page3, page4]

  }()

  var pageControl: UIPageControl!

  //MARK: - ViewController lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    dataSource = self
    setupPageControll()
    setViewControllers([orderedViewController.first!], direction: .forward, animated: false, completion: nil)
    delegate = self

  }
}

//MARK: - UTILS - 
extension OnboardingViewController{

	fileprivate func createViewController(backgroundImage: UIImage, text: String, isLast: Bool = false, page: Int) ->OnboardingSceneViewController{

    let viewController = OnboardingSceneViewController.viewController
    viewController?.backgroundImage	= backgroundImage
    viewController?.text 						= text
    viewController?.page 						= page
    viewController?.isLast 					= isLast
    viewController?.delegate				= self
    return viewController!
  }

  fileprivate func setupPageControll(){

    let pageControlHeight: CGFloat = 50
    pageControl = UIPageControl(frame: CGRect(x: 0, y: view.frame.height - pageControlHeight, width: view.frame.width, height: pageControlHeight))
    pageControl.numberOfPages = orderedViewController.count
    pageControl.currentPage = 0

    pageControl.pageIndicatorTintColor = UIColor.FastCloudyBlue.withAlphaComponent(0.6)
    pageControl.currentPageIndicatorTintColor = UIColor.FastPaleTeal

    view.addSubview(pageControl)
  }
}


//MARK: - UIPageViewControllerDataSource -
extension OnboardingViewController: UIPageViewControllerDataSource{

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let VC = viewController as? OnboardingSceneViewController else { return nil}

    let previousIndex = VC.page - 1
    guard previousIndex >= 0 else { return nil }
    guard orderedViewController.count > previousIndex else { return nil}

    return orderedViewController[previousIndex]
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let VC = viewController as? OnboardingSceneViewController else { return nil }

    let nextIndex = VC.page + 1
    guard orderedViewController.count != nextIndex else { return nil }
    guard orderedViewController.count > nextIndex else { return nil }

    return orderedViewController[nextIndex]
  }
}

//MARK: - UIPageViewControllerDelegate - 
extension OnboardingViewController: UIPageViewControllerDelegate{
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    if let currentViewController = pageViewController.viewControllers?[0] as? OnboardingSceneViewController{
      pageControl.currentPage = currentViewController.page
    }
  }
}

//MARK: -OnboardinSceneViewController Delegate - 
extension OnboardingViewController: OnboardingSceneViewControllerDelegate {

  func controllerDidSkipPage(controller: OnboardingSceneViewController) {
    print("Skipping page")
    if controller.page == 2 {
    	setViewControllers([orderedViewController[controller.page + 1]], direction: .forward, animated: true, completion: nil)
    }
  }

  func controllerDidPressPrimaryButton(controller: OnboardingSceneViewController) {
    print("primary button pressed")
  }

  func controllerWillShowPushView(controller: OnboardingSceneViewController) {
    pageControl.isHidden = true
  }

  func controllerWillHidePushView(controller: OnboardingSceneViewController) {
    pageControl.isHidden = false
  }
}


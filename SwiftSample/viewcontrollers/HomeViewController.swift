//
//  HomeViewController.swift
//  SwiftSample
//
//  Created by Garrett Richards on 6/2/14.
//
//

import UIKit


extension UIView {
    func debugBorder()
    {
        self.layer.borderColor = UIColor.redColor().CGColor
        self.layer.borderWidth = 1
    }
    
    func debugBorder(color:UIColor)
    {
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = 1
    }
}

class HomeViewController: UIViewController ,UINavigationControllerDelegate {

    @IBOutlet var btnMap: UIButton
    var mapViewController: MapViewController?
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "home"
        debugButton()
        configureMapViewController()
        
    }
    
    func debugButton()
    {
//        self.btnMap.debugBorder()
    }
    
    func configureMapViewController()
    {
        let mapVC  = MapViewController(nibName: "MapViewController", bundle: nil)
        self.mapViewController = mapVC
        insertViewControllerUnderMapButton(mapVC)
        println(NSStringFromCGRect(self.btnMap.frame))
        mapVC.view.frame = self.btnMap.frame
    }
    
    func insertViewControllerUnderMapButton(viewController:UIViewController?)
    {
        if let vc = viewController {
            self.addChildViewController(vc)
            self.view.insertSubview(vc.view, belowSubview: self.btnMap)
            vc.didMoveToParentViewController(self)
        }
    }
    

    @IBAction func actionMapClicked(AnyObject) {
        
        if let vc = mapViewController{
            self.navigationController.delegate = self
            self.navigationController.showViewController(vc, sender: self)
        }
    }
    
     func navigationController(navigationController: UINavigationController!, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning!
     {
        let animator = Animator()
        animator.operation = operation
        animator.originationFrame = self.btnMap.frame
        return animator
    }

}

class Animator:NSObject, UIViewControllerAnimatedTransitioning {

    var operation:UINavigationControllerOperation
    var originationFrame:CGRect?
    
    init()
    {
        self.operation = .Push
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval
    {
        return 0.4
    }
    
    func animateTransition(ctx: UIViewControllerContextTransitioning!)
    {
        let to = ctx.viewControllerForKey(UITransitionContextToViewControllerKey)
        let from = ctx.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        if(self.operation == .Push)
        {
            if let f  = self.originationFrame{
                to.view.frame = f
            }

            ctx.containerView().addSubview(to.view)
            UIView.animateWithDuration(transitionDuration(ctx), delay: 0, options:.CurveEaseInOut, animations: {() -> Void in
//                to.view.center = ctx.containerView().center
                to.view.frame = ctx.containerView().frame
                }, completion: {(Bool) -> Void in
                    ctx.completeTransition(true)
                }
            )
        }
        else
        {
            ctx.containerView().addSubview(to.view)
            let preBounds = from.view.bounds
            ctx.containerView().addSubview(from.view)
            UIView.animateWithDuration(transitionDuration(ctx), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: {()->Void in
//                from.view.bounds = preBounds;
                if let f  = self.originationFrame{
                    from.view.frame = f;
                }

                }, completion: {(Bool) -> Void in
                    ctx.completeTransition(true)
                    if let home = to as? HomeViewController
                    {
                        home.insertViewControllerUnderMapButton(from)
                    }
                }
            )
        }
    }
    
}


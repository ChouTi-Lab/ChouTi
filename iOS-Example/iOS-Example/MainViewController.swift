//
//  MainViewController.swift
//  iOS-Example
//
//  Created by Honghao Zhang on 2015-08-10.
//  Copyright (c) 2015 Honghao Zhang. All rights reserved.
//

import UIKit
import ChouTi

class MainViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var slideViewController: SlideController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
	}
	
	func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.showBottomHairline()
	}
}

extension MainViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		switch indexPath.row {
		case 0:
			let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self))!
			
			cell.textLabel?.text = "Navigation Bar Hide Hairline"
			
			return cell
		case 1:
			let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self))!
			
			cell.textLabel?.text = "SlideController"
			
			return cell
		case 2:
			let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self))!
			
			cell.textLabel?.text = "Table (Grid) Layout"
			
			return cell
		case 3:
			let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self))!
			
			cell.textLabel?.text = "Page Controller"
			
			return cell
		default:
			return UITableViewCell()
		}
	}
}

extension MainViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		switch indexPath.row {
		case 0:
			let dummyViewController = UIViewController()
			dummyViewController.view.backgroundColor = UIColor.whiteColor()
			self.navigationController?.pushViewController(dummyViewController, animated: true)
			
			dummyViewController.navigationController?.navigationBar.hideBottomHairline()
		case 1:
			let centerVC = CenterViewController(nibName: "CenterViewController", bundle: nil)
			centerVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: UIBarButtonItemStyle.Done, target: self, action: "expandLeft:")
			centerVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: UIBarButtonItemStyle.Done, target: self, action: "expandRight:")
			centerVC.title = "Slide Controller"
			
			let centerNavi = UINavigationController(rootViewController: centerVC)
			
			let leftVC = SideViewController(nibName: "SideViewController", bundle: nil)
			leftVC.view.backgroundColor = UIColor.redColor()
			leftVC.label.text = "Left"
			leftVC.view.frame = UIScreen.mainScreen().bounds
			
			let rightVC = SideViewController(nibName: "SideViewController", bundle: nil)
			rightVC.view.backgroundColor = UIColor.blueColor()
			rightVC.label.text = "Right"
			rightVC.view.frame = UIScreen.mainScreen().bounds
			
			slideViewController = SlideController(centerViewController: centerNavi, leftViewController: leftVC, rightViewController: rightVC)
//			slideViewController = SlideController(centerViewController: centerNavi)
//			slideViewController.rightViewController = rightVC
//			
			slideViewController.animationDuration = 0.25
			slideViewController.springDampin = 1.0
			
			slideViewController.statusBarBackgroundColor = UIColor.whiteColor()
			slideViewController.leftRevealWidth = 200
			slideViewController.rightRevealWidth = 100
			
			slideViewController.shouldExceedRevealWidth = false
			
			centerVC.slideViewController = slideViewController
			centerVC.leftViewController = leftVC
			centerVC.rightViewController = rightVC
			
			slideViewController.toggleLeftViewController()
			
			self.presentViewController(slideViewController, animated: true, completion: nil)
			
		case 2:
			if #available(iOS 9.0, *) {
			    let tableLayoutDemoViewController = TableLayoutDemoViewController()
				self.presentViewController(tableLayoutDemoViewController, animated: true, completion: nil)
			} else {
				assertionFailure()
			}
			
		case 3:
			let demoMenuPageViewController = PageViewController()
			let vc1 = SideViewController(nibName: "SideViewController", bundle: nil)
			vc1.view.backgroundColor = UIColor.blueColor()
			vc1.label.text = "vc1"
			vc1.view.frame = UIScreen.mainScreen().bounds
			
			let vc2 = SideViewController(nibName: "SideViewController", bundle: nil)
			vc2.view.backgroundColor = UIColor.redColor()
			vc2.label.text = "vc2"
			vc1.view.frame = UIScreen.mainScreen().bounds
			
			let vc3 = SideViewController(nibName: "SideViewController", bundle: nil)
			vc3.view.backgroundColor = UIColor.greenColor()
			vc3.label.text = "vc3"
			vc3.view.frame = UIScreen.mainScreen().bounds
			
			let vc4 = SideViewController(nibName: "SideViewController", bundle: nil)
			vc4.view.backgroundColor = UIColor.purpleColor()
			vc4.label.text = "vc4"
			
			demoMenuPageViewController.viewControllers = [vc1, vc2, vc3, vc4]
			
			delay(seconds: 0.5, completion: { _ in
				demoMenuPageViewController.setSelectedIndex(1, animated: true)
			})
			
			delay(seconds: 1.0, completion: { _ in
				demoMenuPageViewController.setSelectedIndex(3, animated: true)
			})
			
			delay(seconds: 1.5, completion: { _ in
				demoMenuPageViewController.setSelectedIndex(0, animated: true)
			})
			
			delay(seconds: 2.0, completion: { _ in
				demoMenuPageViewController.setSelectedIndex(2, animated: true)
			})
			
//			self.presentViewController(demoMenuPageViewController, animated: true, completion: nil)
			self.navigationController?.pushViewController(demoMenuPageViewController, animated: true)
			
		default:
			break
		}
	}
	
	func expandLeft(sender: AnyObject) {
		slideViewController.toggleLeftViewController()
	}
	
	func expandRight(sender: AnyObject) {
		slideViewController.toggleRightViewController()
	}
}

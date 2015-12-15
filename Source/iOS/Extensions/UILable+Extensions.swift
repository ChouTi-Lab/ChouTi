//
//  UILable+Extensions.swift
//  ChouTi
//
//  Created by Honghao Zhang on 2015-09-04.
//

import UIKit

public extension UILabel {
	
	/**
	Get exact size for UILabel, computed with text and font on this label
	
	- returns: CGSize for this label
	*/
	@available(*, deprecated=1.0)
	public func exactSize_deprecated() -> CGSize {
		if let text = text {
			let text: NSString = text
			var newSize = text.sizeWithAttributes([NSFontAttributeName: font])
			newSize.width = ceil(newSize.width)
			newSize.height = ceil(newSize.height)
			return newSize
		} else {
			return CGSizeZero
		}
	}
	
	public func exactSize(preferredMaxWidth preferredMaxWidth: CGFloat? = nil, shouldUseCeil: Bool = false) -> CGSize {
		var size = self.sizeThatFits(CGSize(width: preferredMaxWidth ?? preferredMaxLayoutWidth, height: 0))
		
		if shouldUseCeil {
			size.width = ceil(size.width)
			size.height = ceil(size.height)
		}
		
		return size
	}
	
	/**
	The size of the smallest permissible font with which to draw the label’s text.
	Note: If adjustsFontSizeToFitWidth == false, return fixed size
	
	:returns: minimum font size
	*/
	public func smallestFontSize() -> CGFloat {
		if adjustsFontSizeToFitWidth == true {
			return font.pointSize * minimumScaleFactor
		} else {
			return font.pointSize
		}
	}
}



// MARK: - Animations
public extension UILabel {
	
	/**
	Add a fade in/out text transition animation
	Note: Must be called after label has been displayed
	
	- parameter animationDuration: transition animation duration
	*/
	public func addFadeTransitionAnimation(animationDuration: NSTimeInterval = 0.25) {
		if layer.animationForKey(kCATransitionFade) == nil {
			let animation = CATransition()
			animation.duration = animationDuration
			animation.type = kCATransitionFade
			animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
			layer.addAnimation(animation, forKey: kCATransitionFade)
		}
	}
}

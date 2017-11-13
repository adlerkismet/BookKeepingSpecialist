/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  OverlayAnimatedTransitioning and OverlayTransitioningDelegate interfaces.
  
 */

@import UIKit;

@interface OverlayAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isPresentation;
@end

@interface OverlayTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>
@end

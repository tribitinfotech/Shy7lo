//
//  AFCollectionViewFlowSmallLayout.m
//  UICollectionViewFlowLayoutExample
//
//  Created by Ash Furrow on 2013-02-05.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewFlowSmallLayout.h"

@implementation AFCollectionViewFlowSmallLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width-10)/2, ((252*[[UIScreen mainScreen] bounds].size.width)/568));
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0.0;
    self.minimumLineSpacing = 0.0;
    
    return self;
}

@end

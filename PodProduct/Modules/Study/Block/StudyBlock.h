//
//  StudyBlock.h
//  PodProduct
//
//  Created by wzk on 2018/3/7.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudyBlock : NSObject

@property (nonatomic,strong)void (^blockTest)(NSString* s);
@property (nonatomic,copy)NSString* name;


+ (instancetype)shareStudyBlock;
@end

//
//  Most.m
//  Text
//
//  Created by 王正魁 on 14-5-23.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import "Most.h"

@implementation Most
-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark -- Date --
+(NSString*)getTimeForSystemWithDate
{
    NSDate* data = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return [formatter stringFromDate:data];
}
+(NSString*)getTimeForSystemWithTime
{
    NSDate* data = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [formatter stringFromDate:data];
}
+(NSString*)getTimeForSystemWithTimeAndDate
{
    NSDate* data = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return [formatter stringFromDate:data];
}



#pragma mark -- UIFontHight--
+(float)getHeightWithString:(NSString*)string WithFontSize:(float)size
{
    CGSize s = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0) {
        UIFont *font = [UIFont fontWithName:@"Arial" size:size];
        s = [string sizeWithFont:font];
        
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
//        s = [string sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:size] }];
        
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
        
        CGSize textSize = [string boundingRectWithSize:CGSizeMake(220, 0)  options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return textSize.height;
        
        
    }
    return s.height;
}
+(NSString*)getSubStringWithString:(NSString *)string WithBeginFloat:(float)n WithEndFloat:(float)m
{
    return [string substringWithRange:NSMakeRange(n, m)];
}



#pragma mark -压缩图片
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
#pragma mark -save image to 沙盒
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData;
    if (UIImagePNGRepresentation(tempImage) == nil) {
        
        imageData = UIImageJPEGRepresentation(tempImage, 1);
        
    } else {
        
        imageData = UIImagePNGRepresentation(tempImage);
        
    }
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
//    [self.picturePaths addObject:fullPathToFile];
    //NSLog(@"添加图片路径:%@",self.picturePaths);
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}
#pragma mark -remove image to 沙盒
- (void)removeImage:(NSString *)imageName
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    if ([fileManager fileExistsAtPath:fullPathToFile]) {
        [fileManager removeItemAtPath:fullPathToFile error:nil];
        
//        [self.picturePaths removeObject:fullPathToFile];
        
        // NSLog(@"删除图片路径:%@",self.picturePaths);
    }
    
}




@end

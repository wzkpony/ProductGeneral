//
//  OtherModel.m
//  Text
//
//  Created by 王正魁 on 14-7-4.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import "AudioMethod.h"

@implementation AudioMethod
static  AudioMethod*shareOtherModel = nil;
+(AudioMethod *)sharedController{
    @synchronized(self){
        if(shareOtherModel == nil){
            shareOtherModel = [[self alloc] init];
            
        }
    }
    return shareOtherModel;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (shareOtherModel == nil) {
            shareOtherModel = [super allocWithZone:zone];
            return  shareOtherModel;
        }
    }
    return nil;
}


-(UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    CGImageRelease(thumbnailImageRef);
    return thumbnailImage;
}



-(void)playMusicForProductWithName:(NSString* )string WithType:(NSString*)type
{
    NSError* error = nil;
    //  NSString* path1 = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"笔画.m4a"];
    NSString* path = [[NSBundle mainBundle] pathForResource:string ofType:type];
    
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:&error];
    _player.delegate = self;
    [_player prepareToPlay];
    
}

//播放声音
-(void)playMusicForDocumentWithData:(NSData* )bufer
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithData:bufer error:&error];
    _player.volume = 1;
    _player.delegate = self;
    [_player prepareToPlay];
    if (error !=nil) {
        [self stopMusic];
       
    }
    [self playBigin];

}

//播放声音
-(void)playMusicForDocumentWithPath:(NSString* )path
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    NSError* error = nil;
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:&error];
    _player.volume = 1;
    _player.delegate = self;
    [_player prepareToPlay];
    
}
-(void)closepPlayMusic
{
    [_player   pause];
}
-(void)stopMusic
{

    [_player stop];
}
-(void)playBigin
{
    [_player play];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if ( self.blockForDidFinishAVAudioPlayer == nil) {
        return;
    }
    else{
    self.blockForDidFinishAVAudioPlayer(player,flag);
    }
}
//录音
-(void)recorderWithStringPath:(NSString*)path
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSMutableDictionary *recodSettings=[[NSMutableDictionary alloc] init];
    [recodSettings setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    [recodSettings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recodSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [recodSettings setValue:[NSNumber numberWithInt:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];
    NSURL* utl= [NSURL URLWithString:path];
    self.recorder=[[AVAudioRecorder alloc] initWithURL:utl settings:recodSettings error:nil];
    self.recorder.delegate=self;
    [self.recorder recordForDuration:300];
    [self.recorder prepareToRecord];
    [self.recorder record];
    
}

-(void)recorderStop
{
    [self.recorder stop];
}
-(void)recorderPause
{
    [self.recorder pause];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (self.blockForRecorderDidFinishAVAudioRecorder ==nil) {
        return;
    }
    else
    {
    self.blockForRecorderDidFinishAVAudioRecorder(recorder,flag);
    }
    
}

-(void)playSoundPath:(NSString* )thesoundFilePath
{
    /*
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"Tink" ofType:@"caf"];;
    if (path) {
        SystemSoundID theSoundID;
        OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
        if (error == kAudioServicesNoError) {
            AudioServicesPlaySystemSound(theSoundID);
        }
        else
        {
            NSLog(@"Failed to create sound ");
        }
    }
     */
     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    /*
    SystemSoundID myAlertSound;
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/begin_video_record.caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &myAlertSound);
    AudioServicesPlaySystemSound(myAlertSound);
    */
    
    
    SystemSoundID sameViewSoundID;
    CFURLRef thesoundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:thesoundFilePath];
    AudioServicesCreateSystemSoundID(thesoundURL, &sameViewSoundID);
    //变量SoundID与URL对应
    AudioServicesPlaySystemSound(sameViewSoundID); //播放SoundID声音
}
+(void)playSoundID:(int)soundID{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    if ([[def objectForKey:@"tapSound"] isEqualToString:@"yes"]) {
        SystemSoundID id = soundID;
        AudioServicesPlaySystemSound(id);
    }
   
}


/**
 
 **/
- (void)doVideo:(id)sender {
    
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为动态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie, nil];
    //设置摄像图像品质
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置最长摄像时间
    //imagePickerController.videoMaximumDuration = 30;
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模式视图控制器的形式显示
    /*
     imagePickerController 需要在viewcontroller中弹出，这是需要代理出去
     */
}
-(UIImagePickerController* )imageForVideo
{
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为动态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie, nil];
    //设置摄像图像品质
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置最长摄像时间
    //imagePickerController.videoMaximumDuration = 30;
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模式视图控制器的形式显示
    return imagePickerController;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info patch:(NSString* )fullPathToFile{
    
    [picker dismissModalViewControllerAnimated:YES];
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    //获取视频文件的url
    NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSData *movieData=[[NSData alloc] initWithContentsOfURL:mediaURL];
    
    BOOL movieSuc=[movieData writeToFile:fullPathToFile atomically:NO];
    if (!movieSuc) {
        NSLog(@"写入视频数据失败");
    }
    
    if (self.blockForLuXiang != nil) {
        self.blockForLuXiang();
    }
}



@end

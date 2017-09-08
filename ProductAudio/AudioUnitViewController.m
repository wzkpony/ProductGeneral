//
//  AudioUnitViewController.m
//  ProductAudio
//
//  Created by wzk on 2017/8/9.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import "AudioUnitViewController.h"
#import "ProductAudioAudioUnit.h"

@interface AudioUnitViewController ()

@end

@implementation AudioUnitViewController {
    AUAudioUnit *audioUnit;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if (!audioUnit) {
        return;
    }
    
    // Get the parameter tree and add observers for any parameters that the UI needs to keep in sync with the AudioUnit
}

- (AUAudioUnit *)createAudioUnitWithComponentDescription:(AudioComponentDescription)desc error:(NSError **)error {
    audioUnit = [[ProductAudioAudioUnit alloc] initWithComponentDescription:desc error:error];
    
    return audioUnit;
}

@end

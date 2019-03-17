//
// Created by Rayer on 2019-03-17.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


@interface PasteController : NSObject {

}

@property bool anotherPasteStillOnGoing;

+ (instancetype)sharedInstance;

- (void)handlePasteWithPasteboard:(NSPasteboard*) pasteBoard;

- (void)defaultPasteWithPasteboard:(NSPasteboard*) pb;

- (void)tinyurl:(id)sender;

- (void)imgur:(id)sender;
@end

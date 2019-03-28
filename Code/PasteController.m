//
// Created by Rayer on 2019-03-17.
//

#import <ImgurAnonymousAPIClient.h>
#import "PasteController.h"
#import "YLLGlobalConfig.h"
#import "YLController.h"
#import "NSString+ext.h"


@implementation PasteController {

@private
            bool _anotherPasteStillOnGoing;
}

@synthesize anotherPasteStillOnGoing = _anotherPasteStillOnGoing;

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}


- (void)handlePasteWithPasteboard:(NSPasteboard*) pasteBoard {
    if ([[YLLGlobalConfig sharedInstance] smartPaste] == YES) {
        NSString *clipped = [pasteBoard stringForType:NSPasteboardTypeString];
        //Handle URL & Transform to TinyURL
        if ([clipped UJ_isUrlLike] && [clipped length] > 40) {
            YLController *controller = (id) [NSApp delegate];
            [[controller telnetView] insertText:[self tinyurlWithSourceURLString:clipped]];
            return;
        }

        //Handle imgur with filepath
        NSString *filePath = [pasteBoard stringForType:@"public.file-url"]; //In 10.13, it is [pasteBoard stringForType:NSPasteboardTypeFileURL]
        if (filePath) {
            //Check if it is image
            NSURL *url = [NSURL URLWithString:filePath];
            NSImage *img = [[[NSImage alloc] initWithContentsOfURL:url] autorelease];
            if (img) {
                [self imgurWithData:[img TIFFRepresentation] withCompletionHandler:^(NSURL *imgurURL, NSError *error) {
                    if (error) {
                        NSLog(@"Error! %@", error);
                    }
                    YLController *controller = (id) [NSApp delegate];
                    [[controller telnetView] insertText:[imgurURL absoluteString]];
                }];
                return;
            }
        }

        //Handle imgur pasteboard
        if ([pasteBoard dataForType:NSPasteboardTypePNG] || [pasteBoard dataForType:NSPasteboardTypeTIFF]) {
            NSData *dataImgPng = [pasteBoard dataForType:NSPasteboardTypePNG];
            NSData *dataImgTiff = [pasteBoard dataForType:NSPasteboardTypeTIFF];
            [self imgurWithData:dataImgPng ? dataImgPng : dataImgTiff withCompletionHandler:^(NSURL *imgurURL, NSError *error) {
                if (error) {
                    NSLog(@"Error! %@", error);
                }
                YLController *controller = (id) [NSApp delegate];
                [[controller telnetView] insertText:[imgurURL absoluteString]];
            }];
            return;
        }

        [self defaultPasteWithPasteboard:pasteBoard];
    } else {
        [self defaultPasteWithPasteboard:pasteBoard];
    }
    
    
}

- (void)defaultPasteWithPasteboard:(NSPasteboard*) pb {
    NSArray *types = [pb types];
    if ([types containsObject: NSStringPboardType]) {
        NSString *str = [pb stringForType: NSStringPboardType];
        YLController *controller = (id) [NSApp delegate];
        [[controller telnetView] insertText:str withDelay:100];
    }
}

- (NSString*)tinyurlWithSourceURLString:(NSString*) urlString {
    [self setAnotherPasteStillOnGoing:YES];
    NSAlert *alert = [self alertWithTitle:NSLocalizedString(@"Converting URL to TinyURL...", @"Converting URL to TinyURL...") andDetail:NSLocalizedString(@"It may take several seconds, please wait", @"It may take several seconds, please wait")];
    NSString* APIRequestString = [@"http://tinyurl.com/api-create.php?url=" stringByAppendingString:urlString];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:APIRequestString]];
    [request setHTTPMethod:@"GET"];
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", APIRequestString, (long)[responseCode statusCode]);
        return @"";
    }
    
    NSString *tinyurlResult = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    [[NSApp mainWindow] endSheet:alert.window];
    [self setAnotherPasteStillOnGoing:NO];
    return tinyurlResult;
}

- (void)imgurWithData:(NSData*) imgData withCompletionHandler:(void (^)(NSURL *, NSError *))completionHandler; {
    [self setAnotherPasteStillOnGoing:YES];
    NSAlert *alert = [self alertWithTitle:NSLocalizedString(@"Pasting to imgur...", @"Pasting to imgur...") andDetail:NSLocalizedString(@"It may take several seconds, please wait", @"It may take several seconds, please wait")];
    
    [[ImgurAnonymousAPIClient sharedClient] uploadImageData:imgData withFilename:@"nally-uploaded" completionHandler:^(NSURL *imgurURL, NSError *error) {
        completionHandler(imgurURL, error);
        [[NSApp mainWindow] endSheet:alert.window];
        //It will clear contents so it won't be paste again
        [[NSPasteboard generalPasteboard] clearContents];
        [self setAnotherPasteStillOnGoing:NO];
    }];
}

- (void)tinyurl: (id)sender
{
    NSString *tinyUrlResult = [self tinyurlWithSourceURLString:[sender representedObject]];
    YLController *controller = (id) [NSApp delegate];
    [[controller telnetView] insertText: tinyUrlResult];
}

- (void)imgur:(id)sender {
    [self imgurWithData:[sender representedObject] withCompletionHandler:^(NSURL *imgurURL, NSError *error) {
        if(error) {
            NSLog(@"Error! %@", error);
        }
        YLController *controller = (id) [NSApp delegate];
        [[controller telnetView] insertText:[imgurURL absoluteString]];
    }];
}

-(NSAlert*) alertWithTitle:(NSString*)title andDetail:(NSString*)detail {
    NSAlert *alert = [[NSAlert new] autorelease];
    [alert setMessageText:title];
    [alert setInformativeText:detail];
    NSButton* dismissBtn = [alert addButtonWithTitle:NSLocalizedString(@"Dismiss", @"Dismiss alert when it freeze...")];
    [dismissBtn setHidden:YES];
    NSTimer* timer = [NSTimer timerWithTimeInterval:10 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [dismissBtn setHidden:NO];
    }];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert beginSheetModalForWindow:[NSApp mainWindow] completionHandler:nil];
    return alert;
}
@end

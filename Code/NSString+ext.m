//
//  NSString+ext.m
//  Nally
//
//  Created by Rayer on 2019/3/17.
//

#import "NSString+ext.h"

@implementation NSString (UJStringUrlCategory)
- (BOOL) UJ_isUrlLike
{
    NSURL *url = [NSURL URLWithString:self];
    return url && url.scheme && url.host;
}

- (NSString *) UJ_protocolPrefixAppendedUrlString
{
    NSArray *protocols = @[@"http://", @"https://", @"ftp://", @"telnet://",
                           @"bbs://", @"ssh://", @"mailto:"];
    for (NSString *p in protocols)
    {
        if ([self hasPrefix:p])
            return self;
    }
    return [@"http://" stringByAppendingString:self];
}

@end

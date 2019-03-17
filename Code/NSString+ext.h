//
//  NSString+ext.h
//  Nally
//
//  Created by Rayer on 2019/3/17.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (UJStringUrlCategory)
- (BOOL) UJ_isUrlLike;
- (NSString *) UJ_protocolPrefixAppendedUrlString;
@end

NS_ASSUME_NONNULL_END

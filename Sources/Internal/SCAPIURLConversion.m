//
//  SCAPIURLConversion.m
//  SquarePointOfSaleSDK
//
//  Created by Mike Silvis on 3/30/20.
//

#import "SCAPIURLConversion.h"

NSString *__nonnull const SCAPIRequestURLKey = @"square_request";

@implementation SCAPIURLConversion

+ (nonnull NSURL *)encode:(nonnull NSURL *)url;
{
    if (url.host) {
        return [[url copy] URLByAppendingPathComponent:SCAPIRequestURLKey];
    }

    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url
                                               resolvingAgainstBaseURL:NO];
    components.host = SCAPIRequestURLKey;

    return [components URL];
}

+ (nonnull NSURL *)decode:(nonnull NSURL *)url;
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url
                                               resolvingAgainstBaseURL:NO];

    if ([components.host isEqualToString:SCAPIRequestURLKey]) {
        components.host = @"";
    } else {
        NSURL *updatedURL = [url URLByDeletingLastPathComponent];

        components = [[NSURLComponents alloc] initWithURL:updatedURL
                                  resolvingAgainstBaseURL:NO];

        // Remove trailing slash
        if ([components.path hasSuffix:@"/"]) {
            components.path = [components.path substringToIndex:components.path.length - 1];
        }
    }

    return [components URL];
}

+ (BOOL)isEncoded:(nonnull NSURL *)url;
{
    if ([url.host isEqualToString:SCAPIRequestURLKey]) {
        return YES;
    }

    for (NSString *pathComponent in url.pathComponents) {
        if ([pathComponent isEqualToString:SCAPIRequestURLKey]) {
            return YES;
        }
    }

    return NO;
}

@end

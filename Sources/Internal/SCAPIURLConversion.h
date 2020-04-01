//
//  SCAPIURLConversion.h
//  SquarePointOfSaleSDK
//
//  Created by Mike Silvis on 3/30/20.
//

#import <Foundation/Foundation.h>

/*
 Helper class that assists in working around sourceApplication
 returning nil in iOS versions greater than 13.
 */
@interface SCAPIURLConversion : NSObject

/// Converts a URL that allows Square to determine it's origin.
+ (nonnull NSURL *)encode:(nonnull NSURL *)url;

/// Returns a Square converted URL to it's original format to be consumed.
+ (nonnull NSURL *)decode:(nonnull NSURL *)url;

/// Returns whether or not the given URL has been encoded by Square.
+ (BOOL)isEncoded:(nonnull NSURL *)url;

@end

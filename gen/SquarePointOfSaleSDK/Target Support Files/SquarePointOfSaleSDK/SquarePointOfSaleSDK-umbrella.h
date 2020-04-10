#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSDictionary+SCCAdditions.h"
#import "NSError+SCCAdditions.h"
#import "NSError+SCCAPIAdditions.h"
#import "NSError+SCCAPISerializationAdditions.h"
#import "NSURL+SCCAdditions.h"
#import "SCCAPIRequest+Serialization.h"
#import "SCCAPIResponse+Serialization.h"
#import "SCCMoney+Serialization.h"
#import "SCAPIURLConversion.h"
#import "SCCAPIConnection.h"
#import "SCCAPIConnection_Testing.h"
#import "SCCAPIRequest.h"
#import "SCCAPIResponse.h"
#import "SCCMoney.h"
#import "SquarePointOfSaleSDK.h"

FOUNDATION_EXPORT double SquarePointOfSaleSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char SquarePointOfSaleSDKVersionString[];


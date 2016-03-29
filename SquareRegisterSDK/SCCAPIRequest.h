//
//  SCCAPIRequest.h
//  SquareRegisterSDK
//
//  Created by Mark Jen on 2/9/14.
//  Copyright (c) 2014 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>


@class SCCMoney;


typedef NS_OPTIONS(NSUInteger, SCCAPIRequestTenderTypes) {
    /// Allow the merchant to accept all API-supported tender types to complete the payment.
    SCCAPIRequestTenderTypeAll = NSUIntegerMax,

    /// Allow the merchant to accept card tenders to complete the payment.
    SCCAPIRequestTenderTypeCard = 1 << 0,
};


/**
 Immutable value type representing the totality of a Register API request.
 */
@interface SCCAPIRequest : NSObject <NSCopying>

/**
 Sets the client ID to associate with all subsequent API requests.
 The client ID must be set to something other than nil before the first API request object is created.
 @param clientID The client ID to associate with all subsequent API requests.
 */
+ (void)setClientID:(nullable NSString *)clientID;

/**
 Designated initializer for the Register API request.
 @param callbackURL The URL that Square Register sends responses to. 
   Must use the custom URL scheme you specified on your application dashboard. Required.
 @param amount The amount of money to charge for the payment. Required.
 @param userInfoString If you provide this value, it's passed along to your application's 
   callbackURL after the payment completes. Use this parameter to associate any 
   helpful state information with the payment request. Optional.
 @param merchantID The merchant's Square-issued ID. Optional.
 @param notes A custom note to associate with the resulting payment. Optional.
 @param supportedTenderTypes The types of tender that Square Register is allowed to accept for the payment. Required.
 @param clearsDefaultFees If YES, default fees (i.e., taxes) are not automatically applied to the payment in Square Register.
 @param autoreturn If NO, merchant must tap New Sale in Register to switch back to requesting application on the receipt screen.
   If YES, Register will automatically switch back to the requesting application after a timeout elapses from the receipt screen.
 @param error Stores an error (domain SCCErrorDomain) in the event one or more parameters are invalid.
 */
+ (nullable instancetype)requestWithCallbackURL:(nonnull NSURL *)callbackURL
                                         amount:(nonnull SCCMoney *)amount
                                 userInfoString:(nullable NSString *)userInfoString
                                     merchantID:(nullable NSString *)merchantID
                                          notes:(nullable NSString *)notes
                           supportedTenderTypes:(SCCAPIRequestTenderTypes)supportedTenderTypes
                              clearsDefaultFees:(BOOL)clearsDefaultFees
                returnAutomaticallyAfterPayment:(BOOL)autoreturn
                                          error:(out NSError *__nullable *__nullable)error;

/// Application Client ID bound to the request at the time of creation.
@property (nonatomic, copy, readonly, nonnull) NSString *clientID;

/// The URL that Square Register sends responses to.
@property (nonatomic, copy, readonly, nonnull) NSURL *callbackURL;

/// The amount of money to charge for the payment.
@property (nonatomic, copy, readonly, nonnull) SCCMoney *amount;

/// Free-form string passed along to your application's callbackURL after the payment completes.
@property (nonatomic, copy, readonly, nullable) NSString *userInfoString;

/// The merchant's Square-issued ID.
@property (nonatomic, copy, readonly, nullable) NSString *merchantID;

/// A custom note to associate with the resulting payment.
@property (nonatomic, copy, readonly, nullable) NSString *notes;

/// The types of tender that Square Register is allowed to accept for the payment.
@property (nonatomic, assign, readonly) SCCAPIRequestTenderTypes supportedTenderTypes;

/// If YES, default fees (i.e., taxes) are not automatically applied to the payment in Square Register.
@property (nonatomic, assign, readonly) BOOL clearsDefaultFees;

/// If NO, merchant must tap New Sale in Register to switch back to requesting application on the receipt screen.
/// If YES, Register will automatically switch back to the requesting application after a timeout elapses.
@property (nonatomic, assign, readonly) BOOL returnsAutomaticallyAfterPayment;

/**
 @param request The request to compare the receiver to.
 @return YES if the receiver and `request` are logically equivalent.
 */
- (BOOL)isEqualToAPIRequest:(nullable SCCAPIRequest *)request;

@end


@interface SCCAPIRequest ()

/**
 @see requestWithCallbackURL:amount:userInfoString:merchantID:notes:supportedTenderTypes:clearsDefaultFees:returnAutomaticallyAfterPayment:error:
 */
+ (nonnull instancetype)new  NS_UNAVAILABLE;

/**
 @see requestWithCallbackURL:amount:userInfoString:merchantID:notes:supportedTenderTypes:clearsDefaultFees:returnAutomaticallyAfterPayment:error:
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

@end

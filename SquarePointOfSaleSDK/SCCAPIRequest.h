//
//  SCCAPIRequest.h
//  SquarePointOfSaleSDK
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

    /// Allow the merchant to accept cash tenders to complete the payment.
    SCCAPIRequestTenderTypeCash = 1 << 1,

    /// Allow the merchant to accept other tenders to complete the payment.
    SCCAPIRequestTenderTypeOther = 1 << 2,

    /// Allow the merchant to accept Square gift cards to complete the payment.
    SCCAPIRequestTenderTypeSquareGiftCard = 1 << 3,

    /// Allow the merchant to accept Square customers' cards on file to complete the payment.
    SCCAPIRequestTenderTypeCardOnFile = 1 << 4
};


/**
 Immutable value type representing the totality of a Point of Sale API request.
 */
@interface SCCAPIRequest : NSObject <NSCopying>

/**
 Sets the client ID to associate with all subsequent API requests.
 The client ID must be set to something other than nil before the first API request object is created.
 @param clientID The client ID to associate with all subsequent API requests.
 */
+ (void)setClientID:(nullable NSString *)clientID;

/**
 Designated initializer for the Point of Sale API request.
 @param callbackURL The URL that Square Point of Sale sends responses to.
 Must use the custom URL scheme you specified on your application dashboard. Required.
 @param amount The amount of money to charge for the payment. Required.
 @param userInfoString If you provide this value, it's passed along to your application's
 callbackURL after the payment completes. Use this parameter to associate any
 helpful state information with the payment request. Optional.
 @param locationID The business location's Square-issued ID. Optional.
 @param notes A custom note to associate with the resulting payment. Optional.
 @param supportedTenderTypes The types of tender that Square Point of Sale is allowed to accept for the payment. Required.
 @param clearsDefaultFees If YES, default fees (i.e., taxes) are not automatically applied to the payment in Square Point of Sale.
 @param autoreturn If NO, merchant must tap New Sale in Point of Sale to switch back to requesting application on the receipt screen.
 If YES, Point of Sale will automatically switch back to the requesting application after a timeout elapses from the receipt screen.
 Note that if the merchant taps the "Add Customer" or "Save Card on File" buttons at the end of the payment flow, causing a modal
 to appear in Point of Sale before the auto return timeout elapses, we will not automatically switch back to your application, regardless
 of the value of this parameter.
 @param customerID The Square-issued ID for the merchant's customer associated with this transaction.
 @param error Stores an error (domain SCCErrorDomain) in the event one or more parameters are invalid.
 */
+ (nullable instancetype)requestWithCallbackURL:(nonnull NSURL *)callbackURL
                                         amount:(nonnull SCCMoney *)amount
                                 userInfoString:(nullable NSString *)userInfoString
                                     locationID:(nullable NSString *)locationID
                                          notes:(nullable NSString *)notes
                                     customerID:(nullable NSString*)customerID
                           supportedTenderTypes:(SCCAPIRequestTenderTypes)supportedTenderTypes
                              clearsDefaultFees:(BOOL)clearsDefaultFees
                returnAutomaticallyAfterPayment:(BOOL)autoreturn
                                          error:(out NSError *__nullable *__nullable)error;

+ (nullable instancetype)requestWithCallbackURL:(nonnull NSURL *)callbackURL
                                         amount:(nonnull SCCMoney *)amount
                                 userInfoString:(nullable NSString *)userInfoString
                                     merchantID:(nullable NSString *)merchantID
                                          notes:(nullable NSString *)notes
                                     customerID:(nullable NSString*)customerID
                           supportedTenderTypes:(SCCAPIRequestTenderTypes)supportedTenderTypes
                              clearsDefaultFees:(BOOL)clearsDefaultFees
                returnAutomaticallyAfterPayment:(BOOL)autoreturn
                                          error:(out NSError *__nullable *__nullable)error __deprecated_msg("Use requestWithCallbackURL:amount:userInfoString:locationID:notes:customerID:supportedTenderTypes:clearsDefaultFees:returnAutomaticallyAfterPayment:error: instead.");

/// Application Client ID bound to the request at the time of creation.
@property (nonatomic, copy, readonly, nonnull) NSString *clientID;

/// The URL that Square Point of Sale sends responses to.
@property (nonatomic, copy, readonly, nonnull) NSURL *callbackURL;

/// The amount of money to charge for the payment.
@property (nonatomic, copy, readonly, nonnull) SCCMoney *amount;

/// Free-form string passed along to your application's callbackURL after the payment completes.
@property (nonatomic, copy, readonly, nullable) NSString *userInfoString;

/// The business location's Square-issued ID.
@property (nonatomic, copy, readonly, nullable) NSString *merchantID __deprecated_msg("Use locationID instead");

/// The business location's Square-issued ID.
@property (nonatomic, copy, readonly, nullable) NSString *locationID;

/// The Square-issued ID for the merchant's customer associated with this transaction.
@property (nonatomic, copy, readonly, nullable) NSString *customerID;

/// A custom note to associate with the resulting payment.
@property (nonatomic, copy, readonly, nullable) NSString *notes;

/// The types of tender that Square Point of Sale is allowed to accept for the payment.
@property (nonatomic, assign, readonly) SCCAPIRequestTenderTypes supportedTenderTypes;

/// If YES, default fees (i.e., taxes) are not automatically applied to the payment in Square Point of Sale.
@property (nonatomic, assign, readonly) BOOL clearsDefaultFees;

/// If NO, merchant must tap New Sale in Point of Sale to switch back to requesting application on the receipt screen.
/// If YES, Point of Sale will automatically switch back to the requesting application after a timeout elapses.
/// Note that if the merchant taps the "Add Customer" or "Save Card on File" buttons at the end of the payment flow, causing a modal
/// to appear in Point of Sale before the auto return timeout elapses, we will not automatically switch back to your application, regardless
/// of the value of this parameter.
@property (nonatomic, assign, readonly) BOOL returnsAutomaticallyAfterPayment;

/**
 @param request The request to compare the receiver to.
 @return YES if the receiver and `request` are logically equivalent.
 */
- (BOOL)isEqualToAPIRequest:(nullable SCCAPIRequest *)request;

@end


@interface SCCAPIRequest ()

/**
 @see requestWithCallbackURL:amount:userInfoString:locationID:notes:customerID:supportedTenderTypes:clearsDefaultFees:returnAutomaticallyAfterPayment:error:
 */
+ (nonnull instancetype)new  NS_UNAVAILABLE;

/**
 @see requestWithCallbackURL:amount:userInfoString:locationID:notes:customerID:supportedTenderTypes:clearsDefaultFees:returnAutomaticallyAfterPayment:error:
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

@end

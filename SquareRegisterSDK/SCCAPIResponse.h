//
//  SCCAPIResponse.h
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


/**
 Create an instance of this class for easy access to the values provided by Square Register's 
 callback to your app. These values summarize the result of a SCCAPIRequest 
 your app sent to Square Register. Immutable value type.
 */
@interface SCCAPIResponse : NSObject <NSCopying>

/**
 Construct a response object from a response URL.
 @param URL Response URL from Register.
 @param error Stores an error in the event the callback URL does not contain a valid API response.
 @return An instance of SCCAPIResponse if the callback URL contains a well-formed response,
   (whether a success or an error response) otherwise returns nil.
 */
+ (nullable instancetype)responseWithResponseURL:(nonnull NSURL *)URL error:(out NSError *__nullable *__nullable)error;

/** 
 The value you provided for userInfoString in your SCCAPIRequest, if any.
 This value is available even if an error occurred during the request.
 */
@property (nonatomic, copy, readonly, nullable) NSString *userInfoString;

/** 
 Contains details of the API error that occurred during the payment request, if any. Otherwise, nil.
 */
@property (nonatomic, copy, readonly, nullable) NSError *error;

/** 
 @return NO if this response contains an error, otherwise YES.
 */
@property (nonatomic, assign, readonly, getter=isSuccessResponse) BOOL successResponse;

/** 
 The unique ID of the processed payment, if the payment succeeded. Otherwise, nil.
 This value is also nil if the payment was processed in offline mode.
 You can use this ID to get the full details of the payment with the Square Connect API.
 */
@property (nonatomic, copy, readonly, nullable) NSString *paymentID;

/**
 The payment's unique offline ID, generated in case the payment needed to be processed 
 in offline mode. Note that this value is present even if the payment was not processed 
 in offline mode.
 */
@property (nonatomic, copy, readonly, nullable) NSString *offlinePaymentID;

/**
 The ID of the transaction.
 */
@property (nonatomic, copy, readonly, nullable) NSString *transactionID;

/**
 @param response The response to compare the receiver to.
 @return YES if the receiver and `response` are logically equivalent.
 */
- (BOOL)isEqualToAPIResponse:(nullable SCCAPIResponse *)response;

@end


@interface SCCAPIResponse ()

/**
 @see responseWithResponseURL:error:
 */
+ (nonnull instancetype)new  NS_UNAVAILABLE;

/**
 @see responseWithResponseURL:error:
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

@end

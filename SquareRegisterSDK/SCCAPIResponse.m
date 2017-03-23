//
//  SCCAPIResponse.m
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

#import "SCCAPIResponse.h"
#import "SCCAPIResponse+Serialization.h"

#import "NSError+SCCAdditions.h"
#import "NSError+SCCAPIAdditions.h"
#import "NSError+SCCAPISerializationAdditions.h"
#import "NSDictionary+SCCAdditions.h"
#import "NSURL+SCCAdditions.h"


NSString *__nonnull const SCCAPIResponseDataKey = @"data";
NSString *__nonnull const SCCAPIResponseStatusKey = @"status";
NSString *__nonnull const SCCAPIResponseErrorCodeKey = @"error_code";
NSString *__nonnull const SCCAPIResponseTransactionIDKey = @"transaction_id";
NSString *__nonnull const SCCAPIResponseClientTransactionIDKey = @"client_transaction_id";
NSString *__nonnull const SCCAPIResponseStateKey = @"state";

NSString *__nonnull const SCCAPIResponseStatusStringOK = @"ok";
NSString *__nonnull const SCCAPIResponseStatusStringError = @"error";


@implementation SCCAPIResponse

#pragma mark - Class Methods

+ (nullable instancetype)responseWithResponseURL:(nonnull NSURL *)URL error:(out NSError *__nullable *__nullable)error;
{
    NSDictionary *const parameters = [URL SCC_HTTPGETParameters];

    NSString *const dataString = [parameters SCC_stringForKey:SCCAPIResponseDataKey];
    if (dataString.length == 0) {
        if (error) {
            *error = [NSError SCC_missingOrInvalidResponseDataError];
        }
        return nil;
    }

    NSDictionary *data = nil;
    NSData *const JSONData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    id const JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:(NSJSONReadingOptions)0 error:NULL];
    if (![JSONObject isKindOfClass:[NSDictionary class]]) {
        if (error) {
            *error = [NSError SCC_missingOrInvalidResponseJSONDataError];
        }
        return nil;
    } else {
        data = JSONObject;
    }

    NSString *const statusString = [data SCC_stringForKey:SCCAPIResponseStatusKey];
    SCCAPIResponseStatus const status = SCCAPIResponseStatusFromString(statusString);
    if (status == SCCAPIResponseStatusUnknown) {
        if (error) {
            *error = [NSError SCC_missingOrInvalidResponseStatusError];
        }
        return nil;
    }

    // In a well-formed response, the user info string is always returned if provided in the request.
    NSString *const userInfoString = [data SCC_stringForKey:SCCAPIResponseStateKey];

    // An error response includes an error code as a string.
    if (status == SCCAPIResponseStatusError) {
        NSString *const errorCodeString = [data SCC_stringForKey:SCCAPIResponseErrorCodeKey];
        if (errorCodeString.length == 0) {
            if (error) {
                *error = [NSError SCC_missingOrInvalidResponseErrorCodeError];
            }
            return nil;
        }

        NSError *const APIError = [NSError SCC_APIErrorWithErrorCodeString:errorCodeString];

        return [[self alloc] initWithError:APIError userInfoString:userInfoString];
    }

    NSString *const transactionID = [data SCC_stringForKey:SCCAPIResponseTransactionIDKey];
    NSString *const clientTransactionID = [data SCC_stringForKey:SCCAPIResponseClientTransactionIDKey];
    
    return [[self alloc] initWithTransactionID:transactionID
                           clientTransactionID:clientTransactionID
                                userInfoString:userInfoString];
}

#pragma mark - Initialization

- (nonnull instancetype)initWithError:(nonnull NSError *)error userInfoString:(nullable NSString *)userInfoString;
{
    NSAssert(error != nil, @"Attempting to initialize an error response without an error.");

    self = [super init];
    if (!self) {
        return nil;
    }

    _error = error;
    _userInfoString = [userInfoString copy];

    return self;
}

- (nonnull instancetype)initWithTransactionID:(nullable NSString *)transactionID
                          clientTransactionID:(nullable NSString *)clientTransactionID
                               userInfoString:(nullable NSString *)userInfoString;
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _transactionID = [transactionID copy];
    _clientTransactionID = [clientTransactionID copy];
    _userInfoString = [userInfoString copy];

    return self;
}

#pragma mark - NSObject

- (nonnull NSString *)description;
{
    if (self.successResponse) {
        return [NSString stringWithFormat:@"<%@:%p> { transactionID: %@, userInfoString: %@ }",
            NSStringFromClass(self.class),
            self,
            self.transactionID,
            self.userInfoString];
    } else {
        return [NSString stringWithFormat:@"<%@:%p> { error: %@, userInfoString: %@ }",
            NSStringFromClass(self.class),
            self,
            self.error,
            self.userInfoString];
    }
}

- (NSUInteger)hash;
{
    return self.userInfoString.hash ^ self.error.hash ^ self.clientTransactionID.hash;
}

- (BOOL)isEqual:(nullable id)object;
{
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[SCCAPIResponse class]]) {
        return NO;
    }

    return [self isEqualToAPIResponse:object];
}

#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
{
    // As an immutable value type, self may be returned in place of a copy.
    return self;
}

#pragma mark - Accessors/Mutators

- (BOOL)isSuccessResponse;
{
    return self.error == nil;
}

#pragma mark - Public Methods

- (BOOL)isEqualToAPIResponse:(nullable SCCAPIResponse *)response;
{
    if (!response || (self.isSuccessResponse != response.isSuccessResponse)) {
        return NO;
    }

    BOOL const haveEqualUserInfoStrings = (!self.userInfoString && !response.userInfoString) || [self.userInfoString isEqual:response.userInfoString];
    BOOL const haveEqualErrors = (!self.error && !response.error) || [self.error isEqual:response.error];
    BOOL const haveEqualClientTransactionIDs = (!self.clientTransactionID && !response.clientTransactionID) || [self.clientTransactionID isEqual:response.clientTransactionID];

    return haveEqualUserInfoStrings && haveEqualErrors && haveEqualClientTransactionIDs;
}

@end


#pragma mark - Serialization Functions


SCCAPIResponseStatus SCCAPIResponseStatusFromString(NSString *__nullable statusString)
{
    if (statusString.length == 0) {
        return SCCAPIResponseStatusUnknown;
    }

    if ([statusString isEqualToString:SCCAPIResponseStatusStringOK]) {
        return SCCAPIResponseStatusOK;
    }

    if ([statusString isEqualToString:SCCAPIResponseStatusStringError]) {
        return SCCAPIResponseStatusError;
    }

    return SCCAPIResponseStatusUnknown;
}

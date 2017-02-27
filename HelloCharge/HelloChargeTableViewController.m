//
//  HelloChargeTableViewController.m
//  SquareRegisterSDK Tests
//
//  Created by Joseph Hankin on 9/22/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//


#import "HelloChargeTableViewController.h"

#import "SquareRegisterSDK.h"


// Replace with the Application ID found in the Square Application Dashboard [https://connect.squareup.com/apps].
#warning Dummy client ID must be replaced with the Application ID found in the Square Application Dashboard [https://connect.squareup.com/apps]
NSString *const yourClientID = @"YOUR_CLIENT_ID";

// Replace with your app's callback URL as set in the Square Application Dashboard [https://connect.squareup.com/apps].
// You must also declare this URL scheme in HelloCharge-Info.plist, under URL types.
#warning Dummy callback URL must be replaced with your app's callback URL as set in the Square Application Dashboard [https://connect.squareup.com/apps]
NSString *const yourCallbackURLString = @"hellocharge://callback";


typedef NS_ENUM(NSUInteger, HelloChargeTableViewSection) {
    HelloChargeTableViewSectionAmount,
    HelloChargeTableViewSectionSupportedTenderTypes,
    HelloChargeTableViewSectionOptionalFields,
    HelloChargeTableViewSectionSettings,
    HelloChargeTableViewSectionCOUNT
};


@interface HelloChargeTableViewController ()

@property (nonatomic, assign) SCCAPIRequestTenderTypes supportedTenderTypes;
@property (nonatomic, assign) BOOL clearsDefaultFees;
@property (nonatomic, assign) BOOL returnAutomaticallyAfterPayment;

@property (weak, nonatomic) IBOutlet UITextField *currencyField;
@property (weak, nonatomic) IBOutlet UITextField *amountField;

@property (weak, nonatomic) IBOutlet UITextField *userInfoStringField;
@property (weak, nonatomic) IBOutlet UITextField *notesField;
@property (weak, nonatomic) IBOutlet UITextField *locationIDField;
@property (weak, nonatomic) IBOutlet UITextField *customerIDField;

- (IBAction)oauth:(id)sender;
- (IBAction)charge:(id)sender;

@end


@implementation HelloChargeTableViewController

- (void)awakeFromNib;
{
    [super awakeFromNib];
    
    self.supportedTenderTypes = SCCAPIRequestTenderTypeCard;
    self.clearsDefaultFees = NO;
    self.returnAutomaticallyAfterPayment = YES;

    // Always set the client ID before creating your first API request.
    [SCCAPIRequest setClientID:yourClientID];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
{
    if (indexPath.section == HelloChargeTableViewSectionSupportedTenderTypes) {
        BOOL checked = ((1 << indexPath.row) & self.supportedTenderTypes);
        cell.accessoryType = (checked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
    }
    
    if (indexPath.section == HelloChargeTableViewSectionSettings) {
        if (indexPath.row == 0) {
            cell.accessoryType = (self.clearsDefaultFees ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
        } else if (indexPath.row == 1) {
            cell.accessoryType = (self.returnAutomaticallyAfterPayment ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
        }
    }
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
{
    if (indexPath.section == HelloChargeTableViewSectionSupportedTenderTypes ||
        indexPath.section == HelloChargeTableViewSectionSettings) {
        return indexPath;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == HelloChargeTableViewSectionSupportedTenderTypes) {
        self.supportedTenderTypes ^= (1 << indexPath.row);
    }
    
    if (indexPath.section == HelloChargeTableViewSectionSettings) {
        if (indexPath.row == 0) {
            self.clearsDefaultFees = !self.clearsDefaultFees;
        } else if (indexPath.row == 1) {
            self.returnAutomaticallyAfterPayment = !self.returnAutomaticallyAfterPayment;
        }
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

#pragma mark - Actions

- (IBAction)oauth:(id)sender;
{
    NSURL *oauthURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://squareup.com/oauth2/authorize?client_id=%@&scope=PAYMENTS_WRITE&response_type=token", yourClientID]];
    [[UIApplication sharedApplication] openURL:oauthURL];
}

- (IBAction)charge:(id)sender;
{
    NSString *currencyCodeString = self.currencyField.text.length ? self.currencyField.text : self.currencyField.placeholder;
    NSString *amountString = self.amountField.text.length ? self.amountField.text : self.amountField.placeholder;
    
    NSError *error = nil;
    SCCMoney *amount = [SCCMoney moneyWithAmountCents:amountString.integerValue currencyCode:currencyCodeString error:&error];
    if (error) {
        [self _showErrorMessageWithTitle:@"Invalid Amount" error:error];
        return;
    }
    
    NSString *userInfoString = self.userInfoStringField.text.length ? self.userInfoStringField.text : nil;
    NSString *locationID = self.locationIDField.text.length ? self.locationIDField.text : nil;
    NSString *customerID = self.customerIDField.text.length ? self.customerIDField.text : nil;
    NSString *notes = self.notesField.text.length ? self.notesField.text : nil;
    
    SCCAPIRequest *request = [SCCAPIRequest requestWithCallbackURL:[NSURL URLWithString:yourCallbackURLString]
                                                            amount:amount
                                                    userInfoString:userInfoString
                                                        locationID:locationID
                                                             notes:notes
                                                        customerID:customerID
                                              supportedTenderTypes:self.supportedTenderTypes
                                                 clearsDefaultFees:self.clearsDefaultFees
                                   returnAutomaticallyAfterPayment:self.returnAutomaticallyAfterPayment
                                                             error:&error];
    
    if (error) {
        [self _showErrorMessageWithTitle:@"Invalid Request" error:error];
        return;
    }
    
    if (![SCCAPIConnection performRequest:request error:&error]) {
        [self _showErrorMessageWithTitle:@"Cannot Perform Request" error:error];
    }
}

#pragma mark - Private Methods

- (void)_showErrorMessageWithTitle:(NSString *)title error:(NSError *)error;
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL]];
    [self presentViewController:alertController animated:YES completion:NULL];
}

@end

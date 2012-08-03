//
//  LocalizationViewController.m
//  JJPluralFormExample
//
//  Created by Lin Junjie (Clean Shaven Apps Pte. Ltd.) on 18/7/12.
//  Copyright (c) 2012 Lin Junjie. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "LocalizationViewController.h"
#import "JJPluralForm.h"

#define kLocalizedNDays			NSLocalizedString(@"N_DAYS_PLURAL_STRING", @"N day(s)")
#define kLocalizedEveryNDays	NSLocalizedString(@"EVERY_N_DAYS_PLURAL_STRING", @"Every N day(s)")

static NSString *CellIdentifier = @"Cell";

@implementation LocalizationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString* title = nil;
	
	switch (section) {
		case 0:
			title = @"N day(s)";
			break;
			
		case 1:
			title = @"Every N day(s)";
			break;
			
		default:
			break;
	}
	
	return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
//	if (!cell) {
//		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//	}
	
	NSString* cellLabel = nil;
	
	switch (indexPath.section) {
		case 0:
			cellLabel =
			[JJPluralForm pluralStringForNumber:indexPath.row + 1
                                withPluralForms:kLocalizedNDays
                                usingPluralRule:[kJJPluralFormRule integerValue]
                                localizeNumeral:YES];
			break;

		case 1:
			cellLabel =

			[JJPluralForm pluralStringForNumber:indexPath.row + 1
                                withPluralForms:kLocalizedEveryNDays
                                usingPluralRule:[kJJPluralFormRule integerValue]
                                localizeNumeral:YES];

			break;
			
		default:
			break;
	}
	
	cell.textLabel.text = cellLabel;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

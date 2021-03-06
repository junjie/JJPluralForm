//
//  LocalizationViewController.m
//  JJPluralFormExample
//
//  Created by Lin Junjie (Clean Shaven Apps Pte. Ltd.) on 22/2/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "LocalizationViewController.h"
#import "JJPluralForm.h"

#define kLocalizedNDays			NSLocalizedString(@"N_DAYS_PLURAL_STRING", @"N day(s)")
#define kLocalizedEveryNDays	NSLocalizedString(@"EVERY_N_DAYS_PLURAL_STRING", @"Every N day(s)")

static NSString *CellIdentifier = @"Cell";

@interface LocalizationViewController ()
@property (copy, nonatomic) NSNumberFormatter *groupSeparatedFormatter;
@end

@implementation LocalizationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
		self.title = @"JJPluralForm";
		[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
		
		// Set up a default plural rule to use for the convenience method
		// + pluralStringForNumber:withPluralForms:
		[JJPluralForm setPluralRule:[kJJPluralFormRule integerValue]];
    }
    return self;
}

#pragma mark - Lazy Accessor

- (NSNumberFormatter *)groupSeparatedFormatter
{
	if (_groupSeparatedFormatter)
	{
		return _groupSeparatedFormatter;
	}
	
	NSNumberFormatter *formatter = [NSNumberFormatter new];
	[formatter setNumberStyle:NSNumberFormatterNoStyle];
	[formatter setUsesGroupingSeparator:YES];
	[formatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
	[formatter setGroupingSize:3];
	
	_groupSeparatedFormatter = [formatter copy];
	return _groupSeparatedFormatter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString* title = nil;
	
	switch (section)
	{
		case 0:
		{
			title = @"N day(s) using default separator";
			break;
		}
		case 1:
		{
			title = @"Every N day(s) using custom separator";
			break;
		}
		case 2:
		{
			title = @"N day(s) using custom number formatter";
			break;
		}
		default:
			break;
	}
	
	return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell =
	[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	NSString* cellLabel = nil;
	
	switch (indexPath.section)
	{
		case 0:
		{
			cellLabel =
			[JJPluralForm pluralStringForNumber:indexPath.row + 1
                                withPluralForms:kLocalizedNDays];
			break;
		}

		case 1:
		{
			// Because 'kLocalizedEveryNDays' is using a custom separator,
			// use the longer convenience method here to specify the custom
			// separator.
			cellLabel =
			[JJPluralForm pluralStringForNumber:indexPath.row + 1
                                withPluralForms:kLocalizedEveryNDays
									separatedBy:@"|"
                                usingPluralRule:[kJJPluralFormRule integerValue]
                                localizeNumeral:YES];
			break;
		}
			
		case 2:
		{
			// Use a custom number formatter to format the large numbers
			cellLabel =
			[JJPluralForm pluralStringForNumber:(indexPath.row + 1) * 10000
                                withPluralForms:kLocalizedNDays
									separatedBy:[JJPluralForm pluralFormsSeparator]
								usingPluralRule:[kJJPluralFormRule integerValue]
								numberFormatter:self.groupSeparatedFormatter];
			break;
		}
			
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

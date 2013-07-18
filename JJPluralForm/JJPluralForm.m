//
//  JJPluralForm.h
//  JJPluralForm
//
//  Created by Lin Junjie (Clean Shaven Apps Pte. Ltd.) on 18/7/12.
//  Copyright (c) 2012 Lin Junjie. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "JJPluralForm.h"

@interface JJPluralForm ()
+ (NSUInteger)_indexOfPluralFormWithNumber:(NSUInteger)n forRule:(NSUInteger)rule;
@end

@implementation JJPluralForm

#pragma mark -
#pragma mark Singleton methods

-(id)init {
    return nil;
}

#pragma mark -
#pragma mark Public methods

+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralFormsString
                    usingPluralRule:(NSUInteger)pluralRule
					localizeNumeral:(BOOL)localizeNumeral
{

    NSUInteger theRule = pluralRule;

    if (pluralRule <= 15 ||
		pluralRule == 100 ||
		pluralRule == 102 ||
		pluralRule == 107)
	{
		theRule = pluralRule;
	}

	else {
		theRule = 0;
		NSLog(@"Plural rule %d out of bounds, reset to rule #0", pluralRule);
	}

	NSUInteger idx = [[self class] _indexOfPluralFormWithNumber:number forRule:theRule];
	NSArray* pluralFormsArray = [pluralFormsString componentsSeparatedByString:@";"];
	NSUInteger numberOfForms = [pluralFormsArray count];

	NSString* numberString = nil;
	NSString* pluralForm = nil;

	if (localizeNumeral) {
		numberString =
		[NSNumberFormatter localizedStringFromNumber:@(number)
										 numberStyle:NSNumberFormatterNoStyle];
	} else {
		numberString = [@(number) stringValue];
	}

	NSAssert(idx < numberOfForms, @"Plural form %d exceeds number of plural forms (%d) in string (%@) (using plural rule %d)", idx, numberOfForms, pluralFormsString, theRule);
	
	// Requested plural form exceeds the number of forms available.
	// Attempt to fall back to one useable index, failing which return ERR.
	if (idx >= numberOfForms) {
		
		// There's at least one form to use, set idx to 0
		if (numberOfForms) {
			idx = 0;
		}
		// Else we try using the entire string itself
		else if (pluralFormsString) {
			pluralForm = pluralFormsString;
		}
		// Or if pluralFormsString is nil, we return ERR
		else {
			pluralForm = @"ERR";
		}

	}
	
	if (!pluralForm) {
		pluralForm = [pluralFormsArray objectAtIndex:idx];
	}
	
	return [NSString stringWithFormat:pluralForm, numberString];
}

#pragma mark -
#pragma mark Pluralisation Helper Methods

// Takes a number n and returns the plural form based on self.pluralRule
+ (NSUInteger)_indexOfPluralFormWithNumber:(NSUInteger)n forRule:(NSUInteger)rule {
	
	switch (rule) {
		case 0: {
			// Rule #0, 1 form
			// Mostly Asian, e.g. Chinese, Japanese, Korean, Vietnamese, Thai, Lao
			// 1) everything
			return 0;
			break;
		}
			
		case 100: {
			// Rule #100, extended from 1 to 3 forms
			// Mostly Asian, e.g. Chinese, Japanese, Korean, Vietnamese, Thai, Lao. Swedish
			// 1) is 1
			// 2) is 2
			// 3) everything else
			return n==1 ? 0 : (n==2 ? 1 : 2);
			break;
		}
			
		case 1: {
			// Rule #1, 2 forms
			// English, German, Dutch, Norwegian, Swedish, Italian, Portuguese, Spanish, etc.
			// 1) is 1
			// 2) everything else
			return n != 1 ? 1 : 0;
			break;
		}
			
		case 2: {
			// Rule #2, 2 forms
			// French, Brazilian Portuguese
			// 1) is 0 or 1
			// 2) everything else
			return n > 1 ? 1 : 0;
			break;
		}
			
		case 102: {
			// Rule #102, extended from 2 to 3 forms by separating 'is 0 or 1'
			// French, Brazilian Portuguese
			// 1) is 0
			// 2) is 1
			// 3) everything else
			return n==0 ? 0 : (n==1 ? 1 : 2);
			break;
		}
			
		case 3: {
			// Rule #3, 3 forms
			// Latvian
			// 1) is 0
			// 2) ends in 1, excluding 11
			// 3) everything else
			return (n % 10==1 && n % 100 != 11) ? 1 : (n != 0 ? 2 : 0);
			break;
		}
			
		case 4: {
			// Rule #4, 4 forms
			// Scottish Gaelic
			// 1) is 1 or 11
			// 2) is 2 or 12
			// 3) is 3-10 or 13-19
			// 4) everything else
			return (n==1 || n==11) ? 0 : (
										  n==2 || n==12 ? 1 : (
															   n>0 && n<20 ? 2 : 3
															   )
										  );
			break;
			
		}
			
		case 5: {
			// Rule #4, 4 forms
			// Scottish Gaelic
			// 1) is 1 or 11
			// 2) is 2 or 12
			// 3) is 3-10 or 13-19
			// 4) everything else			
			return n==1 ? 0 : (
							   (n==0||(n%100>0&&n%100<20)) ? 1 : 2
							   );
			break;
			
		}
			
		case 6: {
			// Rule #6, 3 forms
			// Lithuanian
			// 1) ends in 1, excluding 11
			// 2) ends in 0, or ends in 11-19
			// 3) everything else
			return n%10==1&&n%100!=11 ? 0 : (
											 n%10>=2&&(n%100<10||n%100>=20) ? 2 : 1
											 );
			break;
			
		}
			
		case 7 : {
			// Rule #7, 3 forms
			// Russian
			// 1) ends in 1, excluding 11
			// 2) ends in 2-4, excluding 12-14
			// 3) everything else			
			return n%10==1&&n%100!=11 ? 0 : (
											 n%10>=2&&n%10<=4&&(n%100<10||n%100>=20) ? 1 : 2
											 );
			break;
			
		}
			
		case 107: {
			// Rule #107, extended from 3 to 4 forms by adding 'is 1'
			// Russian
			// 1) is 1
			// 2) ends in 1, excluding 1 and 11
			// 3) ends in 2-4, excluding 12-14
			// 4) everything else
			return n==1 ? 0 : (
							   n%10==1&&n%100!=11 ? 1 : (
														 n%10>=2&&n%10<=4&&(n%100<10||n%100>=20) ? 2 : 3
														 )
							   );
			break;
			
		}
			
		case 8: {
			// Rule #8, 3 forms
			// Czech, Slovak
			// 1) is 1
			// 2) is 2-4
			// 3) everything else
			return n==1 ? 0 : (n>=2&&n<=4 ? 1 : 2);
			break;
			
		}
			
		case 9: {
			// Rule #9, 3 forms
			// Polish
			// 1) is 1
			// 2) ends in 2-4, excluding 12-14
			// 3) everything else
			return n==1 ? 0 : (
							   n%10>=2&&n%10<=4&&(n%100<10||n%100>=20) ? 1 : 2
							   );
			break;
			
		}
			
		case 10: {
			// Rule #10, 4 forms
			// Slovenian, Sorbian
			// 1) ends in 01
			// 2) ends in 02
			// 3) ends in 03-04
			// 3) everything else
			return n%100==1 ? 0 : (
								   n%100==2 ? 1 : (
												   n%100==3||n%100==4 ? 2 : 3
												   )
								   );
			break;
			
		}
			
		case 11: {
			// Rule #11, 5 forms
			// Irish Gaelic
			// 1) is 1
			// 2) is 2
			// 3) is 3-6
			// 4) is 7-10
			// 5) everything else
			return n==1 ? 0 : (
							   n==2 ? 1 : (
										   n>=3&&n<=6 ? 2 : (
															 n>=7&&n<=10 ? 3 : 4
															 )
										   )
							   );
			break;
			
		}
			
		case 12: {
			// Rule #12, 5 forms
			// Arabic
			// 1) is 1
			// 2) is 2
			// 3) ends in 03-10
			// 4) everything else but 0, ends in 00-02, excluding 0-2
			// 5) ends in 00-02, excluding 0-2
			// 6) is 0
			return n==0 ? 5 : (
							   n==1 ? 0 : (
										   n==2 ? 1 : (
													   n%100>=3&&n%100<=10 ? 2 : (
																				  n%100>=11&&n%100<=99 ? 3 : 4
																				  )
													   )
										   )
							   );
			break;
			
		}
			
		case 13: {
			// Rule #13, 4 forms
			// Maltese
			// 1) is 1
			// 2) is 0 or ends in 01-10, excluding 1
			// 3) ends in 11-19
			// 4) everything else
			return n==1 ? 0 : (
							   n==0||(n%100>0&&n%100<=10) ? 1 : (
																 n%100>10&&n%100<20 ? 2 : 3
																 )
							   );
			break;
			
		}
			
		case 14: {
			// Rule #14, 3 forms
			// Macedonian
			// 1) ends in 1
			// 2) ends in 2
			// 3) everything else
			return n%10==1 ? 0 : (
								  n%10==2 ? 1 : 2
								  );
			break;
			
		}
			
		case 15: {
			// Rule #15, 2 forms
			// Icelandic
			// 1) ends in 1, excluding 11
			// 2) everything else
			return n%10==1&&n%100!=11 ? 0 : 1;
			break;
			
		}
						
		default:
			break;
	}
	
	return 0;
	
}

@end

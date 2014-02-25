//
//  JJPluralForm.h
//  JJPluralForm 2.0
//
//  Created by Lin Junjie (Clean Shaven Apps Pte. Ltd.) on 22/2/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "JJPluralForm.h"

static JJPluralRule _defaultPluralRule = JJPluralRuleNotARule;
static NSString *_defaultSeparator = @";";
static BOOL _defaultLocalizeNumber = YES;
static NSNumberFormatter *_defaultNumberFormatter = nil;

@interface JJPluralForm ()

@end

@implementation JJPluralForm

+ (void)initialize
{
	_defaultNumberFormatter = [NSNumberFormatter new];
	[_defaultNumberFormatter setNumberStyle:NSNumberFormatterNoStyle];
}

+ (void)setPluralRule:(JJPluralRule)rule
{
	_defaultPluralRule = rule;
}

+ (JJPluralRule)pluralRule
{
	return _defaultPluralRule;
}

+ (void)setPluralFormsSeparator:(NSString *)separator
{
	_defaultSeparator = separator;
}

+ (NSString *)pluralFormsSeparator
{
	return _defaultSeparator;
}

+ (void)setShouldLocalizeNumeral:(BOOL)localizeNumeral
{
	_defaultLocalizeNumber = localizeNumeral;
}

+ (BOOL)shouldLocalizeNumeral
{
	return _defaultLocalizeNumber;
}

+ (void)setDefaultNumberFormatter:(NSNumberFormatter *)formatter
{
	_defaultNumberFormatter = [formatter copy];
}

+ (NSNumberFormatter *)defaultNumberFormatter
{
	return _defaultNumberFormatter;
}

#pragma mark - Methods to Obtain Plural Form

+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms
{
	return [self pluralStringForNumber:number
					   withPluralForms:pluralForms
						   separatedBy:_defaultSeparator
					   usingPluralRule:_defaultPluralRule
					   localizeNumeral:_defaultLocalizeNumber];
}

+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms
					usingPluralRule:(JJPluralRule)pluralRule
					localizeNumeral:(BOOL)localizeNumeral
{
	return [self pluralStringForNumber:number
					   withPluralForms:pluralForms
						   separatedBy:_defaultSeparator
					   usingPluralRule:pluralRule
					   localizeNumeral:localizeNumeral];
}

+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms
						separatedBy:(NSString *)separator
					usingPluralRule:(JJPluralRule)pluralRule
					localizeNumeral:(BOOL)localizeNumeral
{
	NSNumberFormatter *formatter =
	localizeNumeral ?
	_defaultNumberFormatter :
	nil;
	
	return [self pluralStringForNumber:number
					   withPluralForms:pluralForms
						   separatedBy:separator
					   usingPluralRule:pluralRule
					   numberFormatter:formatter];
}

+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms
						separatedBy:(NSString *)separator
					usingPluralRule:(JJPluralRule)pluralRule
					numberFormatter:(NSNumberFormatter *)numberFormatter
{
	NSUInteger expectedNumberOfForms = NSNotFound;
	NSUInteger idx =
	[[self class] jj_indexOfPluralFormForNumber:number
									 pluralRule:pluralRule
							   getNumberOfForms:&expectedNumberOfForms];

	
	if (expectedNumberOfForms == NSNotFound)
	{
		NSAssert(0, @"Plural rule %lu out of bounds", (unsigned long)pluralRule);
		return @"ERR";
	}
	
	NSArray* pluralFormsArray = [pluralForms componentsSeparatedByString:separator];
	NSUInteger numberOfForms = [pluralFormsArray count];
	
	if (numberOfForms != expectedNumberOfForms)
	{
		NSAssert(0, @"Plural rule %lu requires %lu form(s), but %lu form(s) is/are found in '%@'", (unsigned long)pluralRule, (unsigned long)expectedNumberOfForms, (unsigned long)numberOfForms, pluralForms);
		return @"ERR";
	}
	
	else if (idx >= numberOfForms)
	{
		NSAssert(idx < numberOfForms, @"Plural form %lu exceeds number of plural form(s) (%lu) in string (%@) (using plural rule %lu)", (unsigned long)idx, (unsigned long)numberOfForms, pluralForms, (unsigned long)pluralRule);
		return @"ERR";
	}
	
	NSString* numberString = nil;
	NSString* pluralForm = nil;

	if (numberFormatter)
	{
		numberString = [numberFormatter stringFromNumber:@(number)];
	}
	else
	{
		numberString = [@(number) stringValue];
	}
	
	if (!pluralForm)
	{
		pluralForm = pluralFormsArray[idx];
	}
	
	return [NSString stringWithFormat:pluralForm, numberString];
}

#pragma mark - Pluralisation Helper Methods

/**
 * Returns the correct plural form for number \c n based on plural rule \c rule
 *
 * @param n The number qualifying the word.
 * @param pluralRule The plural rule. See \c JJPluralRule for options.
 * @param numberOfFormsOut Upon return, contains the number of forms expected
 * for pluralRule \c rule. Can be \c NULL.
 *
 * @returns The correct plural form to use for a word for number \c n. Returns
 * \c NSNotFound if rule is invalid.
 */
+ (NSUInteger)jj_indexOfPluralFormForNumber:(NSUInteger)n
								 pluralRule:(JJPluralRule)pluralRule
						   getNumberOfForms:(NSUInteger *)numberOfFormsOut
{
	NSUInteger index = NSNotFound;
	NSUInteger numberOfForms = NSNotFound;
	
	switch (pluralRule)
	{
		case JJPluralRuleAsian:
		{
			// Rule #0, 1 form
			// Mostly Asian, e.g. Chinese, Japanese, Korean, Vietnamese, Thai, Lao
			// 1) everything
			index = 0;
			numberOfForms = 1;
			break;
		}
			
		case JJPluralRuleAsianExtended:
		{
			// Rule #100, extended from 1 to 3 forms
			// Mostly Asian, e.g. Chinese, Japanese, Korean, Vietnamese, Thai, Lao. Swedish
			// 1) is 1
			// 2) is 2
			// 3) everything else
			index = n==1 ? 0 : (n==2 ? 1 : 2);
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleEnglish:
		{
			// Rule #1, 2 forms
			// English, German, Dutch, Norwegian, Swedish, Italian, Portuguese, Spanish, etc.
			// 1) is 1
			// 2) everything else
			index = n != 1 ? 1 : 0;
			numberOfForms = 2;
			break;
		}
			
		case JJPluralRuleFrench:
		{
			// Rule #2, 2 forms
			// French, Brazilian Portuguese
			// 1) is 0 or 1
			// 2) everything else
			index = n > 1 ? 1 : 0;
			numberOfForms = 2;
			break;
		}
			
		case JJPluralRuleFrenchExtended:
		{
			// Rule #102, extended from 2 to 3 forms by separating 'is 0 or 1'
			// French, Brazilian Portuguese
			// 1) is 0
			// 2) is 1
			// 3) everything else
			index = n==0 ? 0 : (n==1 ? 1 : 2);
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleLatvian:
		{
			// Rule #3, 3 forms
			// Latvian
			// 1) is 0
			// 2) ends in 1, excluding 11
			// 3) everything else
			index = (n % 10==1 && n % 100 != 11) ? 1 : (n != 0 ? 2 : 0);
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleScottishGaelic:
		{
			// Rule #4, 4 forms
			// Scottish Gaelic
			// 1) is 1 or 11
			// 2) is 2 or 12
			// 3) is 3-10 or 13-19
			// 4) everything else
			index = (n==1 || n==11) ? 0 : (
										   n==2 || n==12 ? 1 : (
																n>0 && n<20 ? 2 : 3
																)
										   );
			numberOfForms = 4;
			break;
		}
			
		case JJPluralRuleRomanian:
		{
			// Rule #5, 3 forms
			// Romanian
			// 1) is 1,
			// 2) is 0 or ends in 01-19, excluding 1
			// 3) everything else
			index = n==1 ? 0 : (
								(n==0||(n%100>0&&n%100<20)) ? 1 : 2
								);
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleLithuanian:
		{
			// Rule #6, 3 forms
			// Lithuanian
			// 1) ends in 1, excluding 11
			// 2) ends in 0, or ends in 11-19
			// 3) everything else
			index = n%10==1&&n%100!=11 ? 0 : (
											  n%10>=2&&(n%100<10||n%100>=20) ? 2 : 1
											  );
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleRussian:
		{
			// Rule #7, 3 forms
			// Russian
			// 1) ends in 1, excluding 11
			// 2) ends in 2-4, excluding 12-14
			// 3) everything else			
			index = n%10==1&&n%100!=11 ? 0 : (
											  n%10>=2&&n%10<=4&&(n%100<10||n%100>=20) ? 1 : 2
											  );
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleRussianExtended:
		{
			// Rule #107, extended from 3 to 4 forms by adding 'is 1'
			// Russian
			// 1) is 1
			// 2) ends in 1, excluding 1 and 11
			// 3) ends in 2-4, excluding 12-14
			// 4) everything else
			index = n==1 ? 0 : (
								n%10==1&&n%100!=11 ? 1 : (
														  n%10>=2&&n%10<=4&&(n%100<10||n%100>=20) ? 2 : 3
														  )
								);
			numberOfForms = 4;
			break;
		}
			
		case JJPluralRuleCzech:
		{
			// Rule #8, 3 forms
			// Czech, Slovak
			// 1) is 1
			// 2) is 2-4
			// 3) everything else
			index = n==1 ? 0 : (n>=2&&n<=4 ? 1 : 2);
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRulePolish:
		{
			// Rule #9, 3 forms
			// Polish
			// 1) is 1
			// 2) ends in 2-4, excluding 12-14
			// 3) everything else
			index = n==1 ? 0 : (
								n%10>=2&&n%10<=4&&(n%100<10||n%100>=20) ? 1 : 2
								);
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleSlovenian:
		{
			// Rule #10, 4 forms
			// Slovenian, Sorbian
			// 1) ends in 01
			// 2) ends in 02
			// 3) ends in 03-04
			// 4) everything else
			index = n%100==1 ? 0 : (
									n%100==2 ? 1 : (
													n%100==3||n%100==4 ? 2 : 3
													)
									);
			numberOfForms = 4;
			break;
		}
			
		case JJPluralRuleIrishGaelic:
		{
			// Rule #11, 5 forms
			// Irish Gaelic
			// 1) is 1
			// 2) is 2
			// 3) is 3-6
			// 4) is 7-10
			// 5) everything else
			index = n==1 ? 0 : (
								n==2 ? 1 : (
											n>=3&&n<=6 ? 2 : (
															  n>=7&&n<=10 ? 3 : 4
															  )
											)
								);
			numberOfForms = 5;
			break;
		}
			
		case JJPluralRuleArabic:
		{
			// Rule #12, 6 forms
			// Arabic
			// 1) is 1
			// 2) is 2
			// 3) ends in 03-10
			// 4) everything else but 0, ends in 00-02, excluding 0-2
			// 5) ends in 00-02, excluding 0-2
			// 6) is 0
			index = n==0 ? 5 : (
								n==1 ? 0 : (
											n==2 ? 1 : (
														n%100>=3&&n%100<=10 ? 2 : (
																				   n%100>=11&&n%100<=99 ? 3 : 4
																				   )
														)
											)
								);
			numberOfForms = 6;
			break;
		}
			
		case JJPluralRuleMaltese:
		{
			// Rule #13, 4 forms
			// Maltese
			// 1) is 1
			// 2) is 0 or ends in 01-10, excluding 1
			// 3) ends in 11-19
			// 4) everything else
			index = n==1 ? 0 : (
								n==0||(n%100>0&&n%100<=10) ? 1 : (
																  n%100>10&&n%100<20 ? 2 : 3
																  )
								);
			numberOfForms = 4;
			break;
		}
			
		case JJPluralRuleMacedonian:
		{
			// Rule #14, 3 forms
			// Macedonian
			// 1) ends in 1
			// 2) ends in 2
			// 3) everything else
			index = n%10==1 ? 0 : (
								   n%10==2 ? 1 : 2
								   );
			numberOfForms = 3;
			break;
		}
			
		case JJPluralRuleIcelandic:
		{
			// Rule #15, 2 forms
			// Icelandic
			// 1) ends in 1, excluding 11
			// 2) everything else
			index = n%10==1&&n%100!=11 ? 0 : 1;
			numberOfForms = 2;
			break;
		}
			
		case JJPluralRuleBreton:
		{
			// Rule #16, 6 forms
			// Breton
			// 1) is 1
			// 2) ends in 1, excluding 1, 11, 71, 91
			// 3) ends in 2, excluding 12, 72, 92
			// 4) ends in 3, 4 or 9 excluding 13, 14, 19, 73, 74, 79, 93, 94, 99
			// 5) ends in 1000000
			// 6) everything else
			index = n%10==1&&n%100!=11&&n%100!=71&&n%100!=91?0:n%10==2&&n%100!=12&&n%100!=72&&n%100!=92?1:(n%10==3||n%10==4||n%10==9)&&n%100!=13&&n%100!=14&&n%100!=19&&n%100!=73&&n%100!=74&&n%100!=79&&n%100!=93&&n%100!=94&&n%100!=99?2:n%1000000==0&&n!=0?3:4;
			numberOfForms = 6;
			break;
		}
			
		case JJPluralRuleNotARule:
		{
			NSLog(@"A plural rule has not been specified.");
			break;
		}
						
		default:
		{
			NSLog(@"Invalid plural rule (%ld) specified.", (long)pluralRule);
			break;
		}
	}
	
	if (numberOfFormsOut != NULL)
	{
		*numberOfFormsOut = numberOfForms;
	}
	
	return index;
}

@end

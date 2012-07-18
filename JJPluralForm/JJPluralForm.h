//
//  JJPluralForm.h
//  JJPluralFormExample
//
//  Created by Lin Junjie on 18/7/12.
//  Copyright (c) 2012 Lin Junjie. All rights reserved.
//
//
//  In English, a word can either be singular or plural (e.g. 1 day, 2 days, 10
//  days). Some languages like Chinese have only one form (eg. 1 天, 2 天, 10 天),
//  while others like Russian have three (1 день, 2 дня, 10 дней).
//
//  Mozilla has codified a set of 17 plural rules across all languages. The
//  rules can be found over here:
//  https://developer.mozilla.org/en/Localization_and_Plurals
//
//  Certain plural rules have been extended to include additional plural rules.
//  For example, even though Chinese usually have only one plural form, some
//  scenarios call for up to three different plural forms.
//
//  For example, the phrase 'Every N months' can be localized in English as
//  'Every 1 month', 'Every 2 months' and 'Every 6 months'. Or more naturally,
//  it can be localized as 'Monthly', 'Every 2 months' and 'Every 6 months'.
//
//  In Chinese, this would be '每月', '每两个月' and '每 6 个月'. A single plural form
//  would result in an unnatural sounding phrase such as '每 2 个月' to a native
//  speaker.

#import <Foundation/Foundation.h>

#define kJJPluralFormRule NSLocalizedString(@"JJ_PLURAL_FORM_RULE", @"Set the string 'JJ_PLURAL_FORM_RULE' to the appropriate rule in each of the Localizable.strings")

@interface JJPluralForm : NSObject

// Specifies the plural rule to use. Rules 0-15 follows the Mozilla's
// specifiations at: https://developer.mozilla.org/en/Localization_and_Plurals
//
// Plural rules found in the range 100-115 are extended versions of their
// counterparts in range 0-15 to provide additional plural forms. Only 3
// extended plural rules are available: 100, 102 and 107.
@property (nonatomic) NSUInteger pluralRule;

+ (id)sharedManager;

// Pass a semicolon separated list of plural forms of a word (e.g. day;days)
// along with the number qualifying the word, indicating whether the number
// should be localized in the current locale in the return string object
- (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralFormsString
					localizeNumeral:(BOOL)localizeNumeral;

// Rule #0, 1 form
// Mostly Asian, e.g. Chinese, Japanese, Korean, Vietnamese, Thai, Lao
// 	  1) everything
//
// Rule #1, 2 forms
// English, German, Dutch, Norwegian, Swedish, Italian, Portuguese, Spanish, etc.
// 	  1) is 1
// 	  2) everything else
//
// Rule #2, 2 forms
// French, Brazilian Portuguese
// 	  1) is 0 or 1
// 	  2) everything else
//
// Rule #3, 3 forms
// Latvian
// 	  1) is 0
// 	  2) ends in 1, excluding 11
// 	  3) everything else
//
// Rule #4, 4 forms
// Scottish Gaelic
// 	  1) is 1 or 11
// 	  2) is 2 or 12
// 	  3) is 3-10 or 13-19
// 	  4) everything else
//
// Rule #5, 3 forms
// Romanian
// 	  1) is 1
// 	  2) is 0 or ends in 01-19, excluding 1
// 	  3) everything else
//
// Rule #6, 3 forms
// Lithuanian
// 	  1) ends in 1, excluding 11
// 	  2) ends in 0, or ends in 11-19
// 	  3) everything else
//
// Rule #7, 3 forms
// Russian
// 	  1) ends in 1, excluding 11
// 	  2) ends in 2-4, excluding 12-14
// 	  3) everything else
//
// Rule #8, 3 forms
// Czech, Slovak
// 	  1) is 1
// 	  2) is 2-4
// 	  3) everything else
//
// Rule #9, 3 forms
// Polish
// 	  1) is 1
// 	  2) ends in 2-4, excluding 12-14
// 	  3) everything else
//
// Rule #10, 4 forms
// Slovenian, Sorbian
// 	  1) ends in 01
// 	  2) ends in 02
// 	  3) ends in 03-04
// 	  3) everything else
//
// Rule #11, 5 forms
// Irish Gaelic
// 	  1) is 1
// 	  2) is 2
// 	  3) is 3-6
// 	  4) is 7-10
// 	  5) everything else
//
// Rule #12, 5 forms
// Arabic
// 	  1) is 1
// 	  2) is 2
// 	  3) ends in 03-10
// 	  4) everything else but 0, ends in 00-02, excluding 0-2
// 	  5) ends in 00-02, excluding 0-2
// 	  6) is 0
//
// Rule #13, 4 forms
// Maltese
// 	  1) is 1
// 	  2) is 0 or ends in 01-10, excluding 1
// 	  3) ends in 11-19
// 	  4) everything else
//
// Rule #14, 3 forms
// Macedonian
// 	  1) ends in 1
// 	  2) ends in 2
// 	  3) everything else
//
// Rule #15, 2 forms
// Icelandic
// 	  1) ends in 1, excluding 11
// 	  2) everything else
//
// Extended Rules
//
// Rule #100, extended from 1 to 3 forms
// Mostly Asian, e.g. Chinese, Japanese, Korean, Vietnamese, Thai, Lao. Swedish
// 	  1) is 1
// 	  2) is 2
// 	  3) everything else
//
// Rule #102, extended from 2 to 3 forms by separating 'is 0 or 1'
// French, Brazilian Portuguese
// 	  1) is 0
// 	  2) is 1
// 	  3) everything else
//
// Rule #107, extended from 3 to 4 forms by adding 'is 1'
// Russian
// 	  1) is 1
// 	  2) ends in 1, excluding 1 and 11
// 	  3) ends in 2-4, excluding 12-14
// 	  4) everything else

@end

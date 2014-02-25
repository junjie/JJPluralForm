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

#import <Foundation/Foundation.h>

/**
 * This is a convenience macro that can be use to obtain the plural rule
 * specified in the localization file by setting the string 'JJ_PLURAL_FORM_RULE'
 * to the appropriate rule in each of the Localizable.strings.
 */
#define kJJPluralFormRule NSLocalizedString(@"JJ_PLURAL_FORM_RULE", @"Set the string 'JJ_PLURAL_FORM_RULE' to the appropriate rule in each of the Localizable.strings")

/**
 * A plural rule governing how words should change depending on the number
 * qualifying the word. In English, there are only two forms, singular (is 1)
 * or plural (everything else). Many Asian languages have only a single form,
 * while some like Arabic has six different forms.
 */
typedef NS_ENUM(NSUInteger, JJPluralRule) {
	JJPluralRuleAsian = 0,				/*!< 1 form:
										 
										 - everything
										 
										 e.g. Chinese, Japanese, Korean,
										 Vietnamese, Thai, Lao */
	
	JJPluralRuleAsianExtended = 100,	/*!< 3 forms. Extended rule #0 from
										 1 to 3 forms by introducing 'is 1'
										 and 'is 2':
										 
										 - is 1
										 
										 - is 2
										 
										 - everything
										 
										 e.g. Chinese, Japanese, Korean,
										 Vietnamese, Thai, Lao, Swedish */
	

	JJPluralRuleEnglish = 1,			/*!< 2 forms:
										 
										 - is 1,
										 
										 - everything else
										 
										 e.g. English, German, Dutch, Norwegian,
										 Swedish, Italian, Portuguese, Spanish,
										 etc. */
	
	JJPluralRuleFrench = 2,				/*!< 2 forms:
										 
										 - is 0 or 1,
										 
										 - everything else
										 
										 e.g. French, Brazilian Portuguese */

	JJPluralRuleFrenchExtended = 102,	/*!< 3 forms. Extended rule #2 from
										 2 to 3 forms by separating 'is 0 or 1'
										 
										 - is 0,
										 
										 - is 1,
										 
										 - everything else
										 
										 e.g. French, Brazilian Portuguese.
										 Also recommended for languages in
										 rule #1, eg. English, to distinguish
										 between 0, 1 and everything else. */
	
	JJPluralRuleLatvian = 3,			/*!< 3 forms:
										 
										 - is 0,
										 
										 - ends in 1, excluding 11
										 
										 - everything else */
	
	JJPluralRuleScottishGaelic = 4,		/*!< 4 forms:
										 
										 - is 1 or 11,
										 
										 - is 2 or 12,
										 
										 - is 3-10 or 13-19
										 
										 - everything else  */
	
	JJPluralRuleRomanian = 5,			/*!< 3 forms:
										 
										 - is 1,
										 
										 - is 0 or ends in 01-19, excluding 1
										 
										 - everything else */
	
	JJPluralRuleLithuanian = 6,			/*!< 3 forms:
										 
										 - ends in 1, excluding 11
										 
										 - ends in 0, or ends in 11-19
										 
										 - everything else */
	
	JJPluralRuleRussian = 7,			/*!< 3 forms:
										 
										 - ends in 1, excluding 11
										 
										 - ends in 2-4, excluding 12-14
										 
										 - everything else */

	JJPluralRuleRussianExtended = 107,	/*!< 4 forms. Extended rule #7 from
										 3 to 4 forms by adding 'is 1'.
										 
										 - is 1
										 
										 - ends in 1, excluding 1 and 11
										 
										 - ends in 2-4, excluding 12-14
										 
										 - everything else */
	
	JJPluralRuleCzech = 8,				/*!< 3 forms:
										 
										 - is 1
										 
										 - is 2-4
										 
										 - everything else,
										 
										 e.g. Czech, Slovak */
	
	JJPluralRulePolish = 9,				/*!< 3 forms:
										 
										 - is 1
										 
										 - ends in 2-4, excluding 12-14
										 
										 - everything else */
	
	JJPluralRuleSlovenian = 10,			/*!< 4 forms:
										 
										 - ends in 01
										 
										 - ends in 02
										 
										 - ends in 03-04
										 
										 - everything else */
	
	JJPluralRuleIrishGaelic = 11,		/*!< 5 forms:
										 
										 - is 1
										 
										 - is 2
										 
										 - is 3-6
										 
										 - is 7-10
										 
										 - everything else */
	
	JJPluralRuleArabic = 12,			/*!< 6 forms:
										 
										 - is 1
										 
										 - is 2
										 
										 - ends in 03-10
										 
										 - everything else but 0, ends in 00-02,
										 excluding 0-2
										 
										 - ends in 00-02, excluding 0-2
										 
										 - is 0 */
	
	JJPluralRuleMaltese = 13,			/*!< 4 forms:
										 
										 - is 1
										 
										 - is 0 or ends in 01-10, excluding 1
										 
										 - ends in 11-19
										 
										 - everything else */
	
	JJPluralRuleMacedonian = 14,		/*!< 3 forms:
										 
										 - ends in 1
										 
										 - ends in 2
										 
										 - everything else */
	
	JJPluralRuleIcelandic = 15,			/*!< 2 forms:
										 
										 - ends in 1, excluding 11
										 
										 - everything else */
	
	JJPluralRuleBreton = 16,			/*!< 6 forms:
										 
										 - is 1
										 
										 - ends in 1, excluding 1, 11, 71, 91
										 
										 - ends in 2, excluding 12, 72, 92
										 
										 - ends in 3, 4 or 9 excluding 13, 14,
										 19, 73, 74, 79, 93, 94, 99
										 
										 - ends in 1000000
										 
										 - everything else */
	
	JJPluralRuleNotARule = 999999		/*!< Not a plural rule */
};

@interface JJPluralForm : NSObject

/**
 * Sets the default plural rule to use if none is specified. This is required
 * if you're using the method \c +pluralStringForNumber:withPluralForms:.
 */
+ (void)setPluralRule:(JJPluralRule)rule;

/**
 * Returns the default plural rule to use if none is specified.
 * Default: \c JJPluralRuleNotARule
 */
+ (JJPluralRule)pluralRule;

/**
 * Sets the default separator for plural forms if none is specified. By default
 * plural forms are separated by semicolons (;), so a plural form string for the
 * word 'day' in English would be 'day;days'. Default: \c ;
 */
+ (void)setPluralFormsSeparator:(NSString *)separator;

/**
 * Returns the default separator for plural forms. Default: \c ;
 */
+ (NSString *)pluralFormsSeparator;

/**
 * Sets whether numbers should be localized with the \c +defaultNumberFormatter
 * before being returned in methods that don't specify them. This primarily
 * affects locales using a different set of numeral symbols such as Arabic.
 * Default: \c YES.
 */
+ (void)setShouldLocalizeNumeral:(BOOL)localizeNumeral;

/**
 * Returns whether numbers should be localized with the \c +defaultNumberFormatter
 * before being returned in methods that don't specify them. Default: \c YES.
 */
+ (BOOL)shouldLocalizeNumeral;

/**
 * Sets a custom number formatter to format numbers returned by the various
 * \c pluralStringForNumber: methods.
 * Default: An \c NSNumberFormatter initialized to current locale with
 * \c NSNumberFormatterNoStyle.
 */
+ (void)setDefaultNumberFormatter:(NSNumberFormatter *)formatter;

/**
 * Returns the default number formatter. Default: An \c NSNumberFormatter
 * initialized to current locale with \c NSNumberFormatterNoStyle.
 */
+ (NSNumberFormatter *)defaultNumberFormatter;

/**
 * Returns a string containing \c number and the correct plural form of a word
 * when qualified by the number. For example, returns '1 day' when \c number is
 * 1, but '2 days' when \c number is 2 with the \c pluralForms "%@ day;%@ days"
 * when using the \c JJPluralRuleEnglish as the plural rule. Before using this
 * method, you must first configure the default plural rule with
 * \c +setPluralRule:
 *
 * @param number The number qualifying the word that we're interested in, e.g.
 * the number '2' in '2 days'.
 * @param pluralForms A semi-colon separated list of different forms of the
 * word. The order of the words must follow the order of the rule specified
 * in \c JJPluralRule. For example, English uses \c JJPluralRuleEnglish (rule
 * #1), which takes 2 forms (is 1, everything else). Localizing the phrase
 * 'N days' would require a string '%@ day;%@ days', where the first form
 * ('%@ day') would be used when \c number is '1', and the second form
 * ('%@ days') for every other number.
 *
 * @returns The \c number and the correct plural form of a word when qualified
 * by \c number (e.g. '2 days').
 */
+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms;

/**
 * Returns a string containing \c number and the correct plural form of a word
 * when qualified by the number. For example, returns '1 day' when \c number is
 * 1, but '2 days' when \c number is 2 for \c pluralRule of
 * \c JJPluralRuleEnglish, and the \c pluralForms "%@ day;%@ days".
 *
 * @param number The number qualifying the word that we're interested in, e.g.
 * the number '2' in '2 days'.
 * @param pluralForms A semi-colon separated list of different forms of the
 * word. The order of the words must follow the order of the rule specified
 * in \c JJPluralRule. For example, English uses \c JJPluralRuleEnglish (rule
 * #1), which takes 2 forms (is 1, everything else). Localizing the phrase
 * 'N days' would require a string '%@ day;%@ days', where the first form
 * ('%@ day') would be used when \c number is '1', and the second form
 * ('%@ days') for every other number.
 * @param pluralRule Specifies the grammatical rule that governs which form of
 * word should be used for the given \c number. See \c JJPluralRule more
 * supported rules, or read more at Mozilla's website:
 * https://developer.mozilla.org/en/Localization_and_Plurals
 * @param localizedNumeral If \c YES, \c number should be localized with
 * \c NSNumberFormatter before being returned in the string. This primarily
 * affects locales using a different set of numeral symbols such as Arabic.
 *
 * @returns The \c number and the correct plural form of a word when qualified
 * by \c number (e.g. '2 days').
 */
+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms
                    usingPluralRule:(JJPluralRule)pluralRule
					localizeNumeral:(BOOL)localizeNumeral;

/**
 * Returns a string containing \c number and the correct plural form of a word
 * when qualified by the number. For example, returns '1 day' when \c number is
 * 1, but '2 days' when \c number is 2 for \c pluralRule of \c JJPluralRuleEnglish,
 * and the \c pluralForms "%@ day;%@ days". This method allows (and requires)
 * you to specify a custom \c separator for the forms in \c pluralForms.
 *
 * @param number The number qualifying the word that we're interested in, e.g.
 * the number '2' in '2 days'.
 * @param pluralForms A list of different forms of the word separated by
 * \c separator. The order of the words must follow the order of the rule
 * specified in \c JJPluralRule. For example, English uses
 * \c JJPluralRuleEnglish (rule #1), which takes 2 forms (is 1, everything
 * else). If \c separator is '|', localizing the phrase 'N days' would require a
 * string '%@ day|%@ days', where the first form ('%@ day') would be used when
 * \c number is '1', and the second form ('%@ days') for every other number.
 * @param separator Specifies how the different plural forms of a word (eg. day,
 * days) in the \c pluralForms are separated
 * @param pluralRule Specifies the grammatical rule that governs which form of
 * word should be used for the given \c number. See \c JJPluralRule more
 * supported rules, or read more at Mozilla's website:
 * https://developer.mozilla.org/en/Localization_and_Plurals
 * @param localizedNumeral If \c YES, \c number should be localized with
 * \c NSNumberFormatter before being returned in the string. This primarily
 * affects locales using a different set of numeral symbols such as Arabic.
 *
 * @returns The \c number and the correct plural form of a word when qualified
 * by \c number (e.g. '2 days').
 */
+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms
						separatedBy:(NSString *)separator
                    usingPluralRule:(JJPluralRule)pluralRule
					localizeNumeral:(BOOL)localizeNumeral;

/**
 * Returns a string containing \c number and the correct plural form of a word
 * when qualified by the number. For example, returns '1 day' when \c number is
 * 1, but '2 days' when \c number is 2 for \c pluralRule of \c JJPluralRuleEnglish,
 * and the \c pluralForms "%@ day;%@ days". This method allows (and requires)
 * you to specify a custom \c separator for the forms in \c pluralForms and 
 * a custom number formatter to format your number.
 *
 * @param number The number qualifying the word that we're interested in, e.g.
 * the number '2' in '2 days'.
 * @param pluralForms A list of different forms of the word separated by
 * \c separator. The order of the words must follow the order of the rule
 * specified in \c JJPluralRule. For example, English uses
 * \c JJPluralRuleEnglish (rule #1), which takes 2 forms (is 1, everything
 * else). If \c separator is '|', localizing the phrase 'N days' would require a
 * string '%@ day|%@ days', where the first form ('%@ day') would be used when
 * \c number is '1', and the second form ('%@ days') for every other number.
 * @param separator Specifies how the different plural forms of a word (eg. day,
 * days) in the \c pluralForms are separated
 * @param pluralRule Specifies the grammatical rule that governs which form of
 * word should be used for the given \c number. See \c JJPluralRule more
 * supported rules, or read more at Mozilla's website:
 * https://developer.mozilla.org/en/Localization_and_Plurals
 * @param numberFormatter If provided, \c number would be localized with
 * the formatter before being returned in the string.
 *
 * @returns The \c number and the correct plural form of a word when qualified
 * by \c number (e.g. '2 days').
 */

+ (NSString *)pluralStringForNumber:(NSUInteger)number
					withPluralForms:(NSString *)pluralForms
						separatedBy:(NSString *)separator
					usingPluralRule:(JJPluralRule)pluralRule
					numberFormatter:(NSNumberFormatter *)numberFormatter;

@end

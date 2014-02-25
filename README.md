# JJPluralForm 2.1
by Lin Junjie ([@jjlin](http://twitter.com/jjlin))

![JJPluralForm Example Project Screenshot](https://github.com/junjie/JJPluralForm/raw/master/JJPluralForms.png)

## What is JJPluralForm?

In English, a word can either be singular or plural (e.g. 1 day, 2 days, 10 days). Some languages like Chinese have only one form (eg. 1 天, 2 天, 10 天), while others like Russian have three (1 день, 2 дня, 10 дней).

Mozilla has codified a set of 17 plural rules across all languages. The rules can be found over here: [https://developer.mozilla.org/en/Localization_and_Plurals](https://developer.mozilla.org/en/Localization_and_Plurals)

`JJPluralForm` is adapted from Mozilla's `PluralForm` to handle plural forms in your Objective-C projects.

Certain plural rules have been extended to include additional plural rules. For example, even though Chinese usually have only one plural form, some scenarios call for up to three different plural forms.

For example, the phrase 'Every N months' can be localized in English as 'Every 1 month', 'Every 2 months' and 'Every 6 months'. Or more naturally, it can be localized as 'Monthly', 'Every 2 months' and 'Every 6 months'.

In Chinese, this would be '每月', '每两个月' and '每 6 个月'. A single plural form would result in an unnatural sounding phrase such as '每 2 个月' to a native speaker.


## Usage

### Import

Import the `JJPluralForm` header file to any implementation file that requires localizing of plural forms.

    #import "JJPluralForm.h"

### Choose a Plural Rule

Pick a suitable rule from `JJPluralForm.h`, and add it to the top of each Localizable.strings file.

For example, adding the following:

    "JJ_PLURAL_FORM_RULE" =
    "1";

to the English version of `Localizable.strings` file would specify that the English localization file uses plural rule number 1, which has 2 forms: 1) is one, and 2) everything else.

A convenience macro `kJJPluralFormRule` is defined in `JJPluralForm.h`, which macro can be used to obtain the plural rule as defined in your `Localizable.strings`. Since this macro returns a string, you'd need to convert this to an integer with `[kJJPluralFormRule integerValue]` when passing the rule to `JJPluralForm`.

### Setting a Default Plural Rule (2.0)

Starting from `JJPluralForm` 2.0, you can configure `JJPluralForm` with a default plural rule with:

    [JJPluralForm setPluralRule:[kJJPluralFormRule integerValue]];
    
This allows you to use the new method `+pluralStringForNumber:withPluralForms:` without specifying the plural rule each time you need to localize a string.

### Localizing a Phrase

To localize a phrase such as 'N day(s)', provide all plural forms in the `Localizable.strings` file in the order as listed in `JJPluralForm.h`, separated by semicolons:

    "N_DAYS_PLURAL_STRING" =
    "%@ day;%@ days";

To obtain the correct plural form for the 'N day(s)' expression, use either:

    [JJPluralForm pluralStringForNumber:N
    					withPluralForms:NSLocalizedString(@"N_DAYS_PLURAL_STRING", @"")
						usingPluralRule:[kJJPluralFormRule integerValue]
						localizeNumeral:YES];

where `N` is the qualifying number. If you'd like the numbers in the returned string to be localized in the current region format, pass `YES` to localizeNumeral. This primarily affects locales using a different set of numeral symbols such as Arabic.

If you've earlier configured a default plural rule with `+setPluralRule:`, you can use the shorter method to obtain the correct plural form without having to specify the plural rule each time:

    [JJPluralForm pluralStringForNumber:N
    					withPluralForms:NSLocalizedString(@"N_DAYS_PLURAL_STRING", @"")];

### Using a Custom Separator (2.0)

By default, `JJPluralForm` uses semicolons to separate plural forms. New in 2.0, you can specify a custom separator. For example, if `N_DAYS_PLURAL_STRING` is separated by pipe character (`|`), i.e. `%@ day|%@ days`, you can use this method to obtain the correct plural form:

    [JJPluralForm pluralStringForNumber:N
    					withPluralForms:NSLocalizedString(@"N_DAYS_PLURAL_STRING", @"")
	    					separatedBy:@"|"
						usingPluralRule:[kJJPluralFormRule integerValue]
						localizeNumeral:YES];

### Using a Custom Number Formatter (2.1)

By default, `JJPluralForms` initializes and caches an `NSNumberFormatter` set to a `numberStyle` of `NSNumberFormatterNoStyle`. Despite the style name, formatting numbers with this formatter has the effect of making numerals appear in the correct script of the region (eg. [Eastern Arabic numerals](http://en.wikipedia.org/wiki/Eastern_Arabic_numerals) for Arabic users).

New in 2.1, you can provide your own cached number formatter using `+setDefaultNumberFormatter:`. This allows you to customize all aspects of how numbers are formatted when they are localized with `JJPluralForm`, for instance, by separating groups of numbers (eg. 1,000,000 vs 1000000).

When calling the following method

    - pluralStringForNumber:withPluralForms:

the number is formatted and localized with the cached number formatter unless it has been disabled with `+setShouldLocalizeNumeral:`. When calling the following methods

    - pluralStringForNumber:withPluralForms:usingPluralRule:localizeNumeral:
    - pluralStringForNumber:withPluralForms:separatedBy:usingPluralRule:localizeNumeral:

the number is formatted and localized with the cached number formatter only if `localizedNumeral` is `YES`.

New in 2.1, you can provide an ad-hoc `NSNumberFormatter` to format the number for each call of `pluralStringForNumber:` using the following method:

    - pluralStringForNumber:withPluralForms:separatedBy:usingPluralRule:numberFormatter:

The sample code further illustrates the use of this method.


## CocoaPods

    pod 'JJPluralForm', '~> 2.1'


## Downloading the code

The code can be downloaded at: [https://github.com/junjie/JJPluralForm](https://github.com/junjie/JJPluralForm)


## License

This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.


## Suggested Attribution Format

Attribution in your app's About page is appreciated.

**Includes [JJPluralForm](https://github.com/junjie/JJPluralForm) code by Lin Junjie**
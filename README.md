# JJPluralForm
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

Import the `JJPluralForm` header file to your app delegate and any other source code that requires localizing of plural forms.

    #import "JJPluralForm.h"

Initialize the JJPluralForm singleton in your app delegate's `application:didFinishLaunchingWithOptions:` with:

    [[JJPluralForm sharedManager] setPluralRule:[kJJPluralFormRule integerValue]];

Pick a suitable rule from `JJPluralForm.h`, and add it to the top of each Localizable.strings file.

For example, adding the following:

    "JJ_PLURAL_FORM_RULE" =
    "1";

to the English version of `Localizable.strings` file would specify that the English localization file uses plural rule number 1, which has 2 forms: 1) is one, and 2) everything else.

To localize a phrase such as 'N day(s)', provide all plural forms in the `Localizable.strings` file in the order as listed in `JJPluralForm.h`, separated by semi-colons:

    "N_DAYS_PLURAL_STRING" =
    "%@ day;%@ days";

To obtain the correct plural form 'N day(s)' expression, use:

    [[JJPluralForm sharedManager] pluralStringForNumber:N
                                        withPluralForms:NSLocalizedString(@"N_DAYS_PLURAL_STRING", @"")
                                        localizeNumeral:YES];
                                  
where `N` is the qualifying number. If you'd like the numbers in the returned string to be localized in the current region format, pass YES to localizeNumeral.
    

## Downloading the code

The code can be downloaded at: [https://github.com/junjie/JJPluralForm](https://github.com/junjie/JJPluralForm)


## License

This Source Code Form is subject to the terms ofthe Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.


## Suggested Attribution Format

Attribution in your app's About page is appreciated.

**Includes [JJPluralForm](https://github.com/junjie/JJPluralForm) code by Lin Junjie**
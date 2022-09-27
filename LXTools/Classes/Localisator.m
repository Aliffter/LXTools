//
//  Localisator.m
//  CustomLocalisator
//
//  Created by yslin on 01/07/2018.
//

#import "Localisator.h"

NSString * const kNotificationLanguageChanged = @"kNotificationLanguageChanged";

#define LANGUAGE_TYPE @"SYSTEM_LANGUAGE_TYPE"   //系统语言程序的Key  LANGUAGE_TYPE取值为0时候是中文，1时候为英文

static NSBundle *_languageBundle;

@implementation Localisator


+ (void)load
{
    NSNumber *type = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_TYPE];
    if (type) {
        [self _setLang:[type integerValue]];
    } else {
        [self _setLang:kLang_device];
    }
}

+ (NSArray *)availableLanguages
{
   return @[@"zh-Hans",@"en"];
}

+ (void)setLanguage:(NSString *)lang
{
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];

    if (!path) {
        _languageBundle = [NSBundle mainBundle];
    } else {
        _languageBundle = [NSBundle bundleWithPath:path];
    }
}

+ (NSString *)localizedStringForKey:(NSString *)key
{
    return [_languageBundle localizedStringForKey:key value:nil table:nil];
}

+ (void)_setLang:(LangType)lang
{
    NSAssert(lang <= kLang_en || lang == kLang_device, @"language type not exists:%lu",(unsigned long)lang);
    
    NSArray *array = [self availableLanguages];
    
    NSString *pref = [[NSLocale preferredLanguages] firstObject];

    if (lang == kLang_device) {
        
        
        NSUInteger idx = [array indexOfObject:pref];
        if (idx != NSNotFound) {
            lang = idx;
        } else {
            if ([pref hasPrefix:@"zh-Hant"]|| [pref hasPrefix:@"zh-Hans"] || [pref isEqualToString:@"zh-HK"] ||[pref isEqualToString:@"zh-TW"]) {
                lang = kLang_zh;
            }else{
                lang = kLang_en;
            }
        }
    }
    if (lang != kLang_device) {
        [self setLanguage:array[lang]];
    }
    else {
        [self setLanguage:pref];
    }
    [[NSUserDefaults standardUserDefaults]setInteger:lang forKey:LANGUAGE_TYPE];
    
}

+ (void)setLang:(LangType)lang
{
    [self _setLang:lang];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLanguageChanged object:nil];
}

+ (LangType)currentLang
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:LANGUAGE_TYPE];
}

+ (NSString *)currentLangString
{
    return [NSString stringWithFormat:@"%lu",(unsigned long)[self currentLang]];
}

@end

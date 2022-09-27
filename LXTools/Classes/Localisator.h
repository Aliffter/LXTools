//
//  Localisator.h
//  CustomLocalisator
//
//  Created by yslin on 01/07/2018.
//

#import <Foundation/Foundation.h>

#define LOCALIZATION(text) [Localisator localizedStringForKey:(text)]

UIKIT_EXTERN NSString * const kNotificationLanguageChanged;

typedef enum : NSUInteger {
    kLang_zh,
    kLang_en,
    kLang_device = NSUIntegerMax
} LangType;

@interface Localisator : NSObject


+ (NSString *)localizedStringForKey:(NSString*)key;

+ (LangType)currentLang;

+ (NSString *)currentLangString;

+ (void)setLang:(LangType)lang;

+ (NSArray *)availableLanguages;


@end

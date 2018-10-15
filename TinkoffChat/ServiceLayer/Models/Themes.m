//
//  Themes.m
//  TinkoffChat
//
//  Created by st.i on 14/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

#import "Themes.h"

@implementation Themes

- (void)dealloc {
    [_theme1 release];
    _theme1 = nil;
    
    [_theme2 release];
    _theme2 = nil;
    
    [_theme3 release];
    _theme3 = nil;
    
    [super dealloc];
}

#pragma mark - Getters

- (UIColor *)theme1 {
    return _theme1;
}

- (UIColor *)theme2 {
    return _theme2;
}

- (UIColor *)theme3 {
    return _theme3;
}

#pragma mark - Setters

- (void)setTheme1:(UIColor *)theme1 {
    [_theme1 release];
    _theme1 = [theme1 retain];
}

- (void)setTheme2:(UIColor *)theme2 {
    [_theme2 release];
    _theme2 = [theme2 retain];
}

- (void)setTheme3:(UIColor *)theme3 {
    [_theme3 release];
    _theme3 = [theme3 retain];
}

@end

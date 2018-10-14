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
    [theme1 release];
    theme1 = nil;
    
    [theme2 release];
    theme2 = nil;
    
    [theme3 release];
    theme3 = nil;
    
    [super dealloc];
}

#pragma mark - Getters

- (UIColor *)theme1 {
    return theme1;
}

- (UIColor *)theme2 {
    return theme2;
}

- (UIColor *)theme3 {
    return theme3;
}

#pragma mark - Setters

- (void)setTheme1:(UIColor *)theme1 {
    [theme1 release];
    theme1 = [theme1 retain];
}

- (void)setTheme2:(UIColor *)theme2 {
    [theme2 release];
    theme2 = [theme2 retain];
}

- (void)setTheme3:(UIColor *)theme3 {
    [theme3 release];
    theme3 = [theme3 retain];
}

@end

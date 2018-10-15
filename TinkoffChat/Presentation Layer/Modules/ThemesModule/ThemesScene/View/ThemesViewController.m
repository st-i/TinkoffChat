//
//  ThemesViewController.m
//  TinkoffChat
//
//  Created by st.i on 13/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

#import "ThemesViewController.h"
#import "ThemesViewControllerDelegate.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *theme1 = [UIColor whiteColor];
    UIColor *theme2 = [UIColor darkGrayColor];
    UIColor *theme3 = [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:238.0/255.0 alpha:1.0];
    _model = [[Themes alloc]init];
    _model.theme1 = theme1;
    _model.theme2 = theme2;
    _model.theme3 = theme3;
    
    [theme3 release]; //если закомментировать, перестает падать; все работает, но, вроде, начинает сжирать память
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSData *appTheme = [[NSUserDefaults standardUserDefaults]objectForKey:@"appTheme"];
    if (appTheme != nil) {
        UIColor *appThemeColor = [NSKeyedUnarchiver unarchivedObjectOfClass:UIColor.class fromData:appTheme error:nil];
        self.view.backgroundColor = appThemeColor;
    }
}

- (void)dealloc {
    [_model release];
    _model = nil;
    _themesDelegate = nil;
    [super dealloc];
}

#pragma mark - Getters

- (id<​ThemesViewControllerDelegate>)themesDelegate {
    return _themesDelegate;
}

- (Themes *)model {
    return _model;
}

#pragma mark - Setters

- (void)setThemesDelegate:(id<​ThemesViewControllerDelegate>)themesDelegate {
    if (_themesDelegate != themesDelegate) {
        _themesDelegate = themesDelegate;
    }
}

- (void)setModel:(Themes *)model {
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
}

#pragma mark - Actions

- (IBAction)closeViewController:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeColorTheme:(UIButton *)sender {
    UIColor *selectedTheme;
    switch (sender.tag) {
        case 1:
            selectedTheme = _model.theme1;
            break;
        case 2:
            selectedTheme = _model.theme2;
            break;
        case 3:
            selectedTheme = _model.theme3;
            break;
        default:
            selectedTheme = [UIColor whiteColor];
            break;
    }
    [_themesDelegate themesViewController:self didSelectTheme:selectedTheme];
}

@end

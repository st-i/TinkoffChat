//
//  ThemesViewControllerDelegate.h
//  TinkoffChat
//
//  Created by st.i on 14/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ThemesViewController;

@protocol ​ThemesViewControllerDelegate <NSObject>

- (void)themesViewController:(ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end

NS_ASSUME_NONNULL_END

//
//  ThemesViewController.h
//  TinkoffChat
//
//  Created by st.i on 13/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ​ThemesViewControllerDelegate;

@interface ThemesViewController : UIViewController {
    id<​ThemesViewControllerDelegate>_themesDelegate;
    Themes *_model;
}

@property (assign, nonatomic) id<​ThemesViewControllerDelegate>themesDelegate;
@property (retain, nonatomic) Themes *model;

@end

NS_ASSUME_NONNULL_END

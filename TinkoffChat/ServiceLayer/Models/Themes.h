//
//  Themes.h
//  TinkoffChat
//
//  Created by st.i on 14/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Themes : NSObject {
    UIColor *_theme1;
    UIColor *_theme2;
    UIColor *_theme3;
}

@property (retain, nonatomic) UIColor *theme1;
@property (retain, nonatomic) UIColor *theme2;
@property (retain, nonatomic) UIColor *theme3;

@end

NS_ASSUME_NONNULL_END

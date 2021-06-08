//
//  AppDelegate.h
//  PotatoesCommunity
//
//  Created by apple on 2021/6/8.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

/// 窗口属性
@property (nonatomic, strong) UIWindow *window;


@end


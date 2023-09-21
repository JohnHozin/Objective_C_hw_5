//
//  ViewController.h
//  Objective_C_lesson_5
//
//  Created by умпет on 18.09.2023.
//  Copyright © 2023 Evgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loader.h"
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController<UISearchBarDelegate>

@property (strong, nonatomic) Loader *loader;
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

-(void) performLoadingWithGETRequest;
-(void) performLoadingWithPOSTRequest;
-(void) performLoadingSearchResultsFromYandex: (NSString *) searchQuery;
@end


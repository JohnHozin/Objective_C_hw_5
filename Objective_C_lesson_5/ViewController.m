//
//  ViewController.m
//  Objective_C_lesson_5
//
//  Created by умпет on 18.09.2023.
//  Copyright © 2023 Evgen. All rights reserved.
//

#import "ViewController.h"
#import "Loader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loader = [Loader new];
    _searchBar.delegate = self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self performLoadingWithGETRequest];
//    [self performLoadingWithPOSTRequest];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self performLoadingSearchResultsFromYandex: searchBar.text];
}

-(void) performLoadingWithGETRequest {
    [self.loader performGETRequestForURL:@"https://postman-echo.com/get" arguments:@{@"first": @"first value", @"second": @"second value"} competion:^(NSDictionary *dict, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"%@", [NSString stringWithFormat:@"Error: %@", error]);
                return;
            }
        NSLog(@"%@", [NSString stringWithFormat:@"%@", dict]);
        });
     }];
}

-(void) performLoadingWithPOSTRequest {
        [self.loader performPOSTRequestForURL:@"https://postman-echo.com/post" arguments:@{@"first": @"first value", @"second": @"second value"} competion:^(NSDictionary *dict, NSError *error) {
           dispatch_async(dispatch_get_main_queue(), ^{
               if (error) {
                   NSLog(@"%@", [NSString stringWithFormat:@"Error: %@", error]);
                   return;
               }
           NSLog(@"%@", [NSString stringWithFormat:@"%@", dict]);
           });
        }];
}
    
- (void)performLoadingSearchResultsFromYandex: (NSString *) searchQuery {
    [self.loader performGETRequestForURL:@"https://yandex.ru/search/" arguments:@{
        @"text": searchQuery
    } completionWithHTML:^(NSString * content, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"%@", [NSString stringWithFormat:@"Error: %@", error]);
                return;
            }
            [self->_webView loadHTMLString:content baseURL:nil];
        });
    }];
}


@end

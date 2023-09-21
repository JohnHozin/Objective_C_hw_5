//
//  Loader.h
//  Objective_C_lesson_5
//
//  Created by умпет on 21.09.2023.
//  Copyright © 2023 Evgen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Loader : NSObject

@property (nonatomic, strong) NSURLSession *session;

-(void) performGETRequestForURL: (NSString *) stringURL
                      arguments: (NSDictionary *) arguments
                      competion: (void(^)(NSDictionary *, NSError *))
                                complition;

-(void) performPOSTRequestForURL: (NSString *) stringURL
                       arguments: (NSDictionary *) arguments
                       competion: (void(^)(NSDictionary *, NSError *))
                                complition;

-(void) performGETRequestForURL: (NSString *) stringURL
                      arguments: (NSDictionary *) arguments
             completionWithHTML: (void(^)(NSString *, NSError *))
                                completion;

@end

NS_ASSUME_NONNULL_END

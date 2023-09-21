//
//  Loader.m
//  Objective_C_lesson_5
//
//  Created by умпет on 21.09.2023.
//  Copyright © 2023 Evgen. All rights reserved.
//

#import "Loader.h"

@implementation Loader

-(NSURLSession *) session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; configuration.HTTPAdditionalHeaders = @{
//            @"Content-Type": @"application/json",
//            @"Accept": @"application/json",
            @"User-Agent": @"iPhone 13 Pro Simulator, iOS 13.5.1"
        };
        
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

-(void) performGETRequestForURL: (NSString *) stringURL
                      arguments: (NSDictionary *) arguments
                      competion: (void(^)(NSDictionary *, NSError *))
                                complition {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:stringURL];
    if (arguments) {
        NSMutableArray<NSURLQueryItem *> *queryItem = [NSMutableArray new];
        for (NSString *key in arguments.allKeys) {
            [queryItem addObject:[NSURLQueryItem queryItemWithName:key value:arguments[key]]];
        }
        urlComponents.queryItems = [queryItem copy];
        NSURL *url = urlComponents.URL;
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error){
            if (error) {
                complition(nil, error);
                return;
            }
            
            NSError *parsingError;
            NSDictionary *dictionary = [self parseJsonData:data error:&parsingError];
            if (parsingError) {
                complition(nil, parsingError);
                return;
            }
            
            complition(dictionary, nil);
        }];
        [dataTask resume];
    }
}

-(void) performPOSTRequestForURL: (NSString *) stringURL
                       arguments: (NSDictionary *) arguments
                       competion: (void(^)(NSDictionary *, NSError *))
                                complition {
    NSURL *url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    if (arguments) {
        NSData *body = [self dataWithJson:arguments error:nil];
        request.HTTPBody = body;
    }
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            complition(nil, error);
            return;
        }
        
        NSError *parsingError;
        NSDictionary *dictionary = [self parseJsonData:data error:&parsingError];
        if (parsingError) {
            complition(nil, parsingError);
            return;
        }
        
        complition(dictionary, nil);
    }];
    
    [dataTask resume];
}

- (NSDictionary *) parseJsonData:(NSData *) data error: (NSError **) error {
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
}

- (NSData *) dataWithJson:(NSDictionary *) dictionary error: (NSError **) error {
    return [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:error];
}




- (void)performGETRequestForURL:(NSString *)stringURL arguments:(NSDictionary *)arguments completionWithHTML:(void (^)(NSString *, NSError *))completion {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:stringURL];
    if (arguments) {
        NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
        for (NSString *key in arguments.allKeys) {
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:arguments[key]]];
        }
        urlComponents.queryItems = [queryItems copy];
    }
    NSURL *url = urlComponents.URL;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error) {
            completion(nil, error);
            return;
        }
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
         completion(content, nil);
        }];
        [dataTask resume];
}
@end

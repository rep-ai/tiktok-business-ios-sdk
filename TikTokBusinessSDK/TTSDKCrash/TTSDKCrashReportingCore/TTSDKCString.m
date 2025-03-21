//
//  TTSDKCString.m
//
//  Created by Karl Stenerud on 2013-02-23.
//
//  Copyright (c) 2012 Karl Stenerud. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "TTSDKCString.h"

@implementation TTSDKCString

+ (TTSDKCString *)stringWithString:(NSString *)string
{
    return [[self alloc] initWithString:string];
}

+ (TTSDKCString *)stringWithCString:(const char *)string
{
    return [[self alloc] initWithCString:string];
}

+ (TTSDKCString *)stringWithData:(NSData *)data
{
    return [[self alloc] initWithData:data];
}

+ (TTSDKCString *)stringWithData:(const char *)data length:(NSUInteger)length
{
    return [[self alloc] initWithData:data length:length];
}

- (id)initWithString:(NSString *)string
{
    return [self initWithCString:[string cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (id)initWithCString:(const char *)string
{
    if ((self = [super init])) {
        _bytes = strdup(string);
        _length = strlen(_bytes);
    }
    return self;
}

- (id)initWithData:(NSData *)data
{
    return [self initWithData:data.bytes length:data.length];
}

- (id)initWithData:(const char *)data length:(NSUInteger)length
{
    if ((self = [super init])) {
        _length = length;
        char *bytes = malloc((unsigned)_length + 1);
        memcpy(bytes, data, _length);
        bytes[_length] = 0;
        _bytes = bytes;
    }
    return self;
}

- (void)dealloc
{
    if (_bytes != NULL) {
        free((void *)_bytes);
    }
}

@end

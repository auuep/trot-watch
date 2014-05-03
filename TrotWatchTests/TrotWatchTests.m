//
//  TrotWatchTests.m
//  TrotWatchTests
//
//  Created by Daniel Andersson on 2014-04-17.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TrotWatchTests : XCTestCase

@end

@implementation TrotWatchTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //given
    NSString *apa = @"bananätare";
    //when
    [self doshit:apa];
    //then
    XCTAssertEqual(apa, @"hästätare", @"det gick åt pipan");
}

@end

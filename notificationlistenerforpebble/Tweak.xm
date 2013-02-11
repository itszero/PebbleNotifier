#import "SpringBoard.h"
#import <AppSupport/AppSupport.h>

%hook SBBulletinBannerController

- (void)observer:(id)observer addBulletin:(BBBulletin*)bulletin forFeed:(unsigned int)feed
{
  NSString *_body = [bulletin.message retain],
           *_sender = [bulletin.title retain];
  NSDictionary *dict = [[NSDictionary alloc] initWithObjects:
      [NSArray arrayWithObjects: _sender, _body, nil]
    forKeys:
      [NSArray arrayWithObjects: @"sender", @"body", nil]
  ];

  CPDistributedMessagingCenter *messagingCenter;
  messagingCenter = [CPDistributedMessagingCenter centerNamed:@"tw.itsZero.PebbleNotifier.MessagingCenter"];
  [messagingCenter sendMessageName:@"newNotification" userInfo:dict];

  [dict release];
  %orig;
}

%end

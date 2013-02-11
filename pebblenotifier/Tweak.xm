#import <AppSupport/AppSupport.h>
#import "Pebble.h"

%hook PBProtocolSessionController

%new
- (void)pebbleNotifierReceivedNotificationNamed:(NSString*)name WithUserInfo:(NSDictionary*)userInfo {
    NSString *sender = [userInfo objectForKey:@"sender"];
    NSString *body   = [userInfo objectForKey:@"body"];

    PBNotification *notification = [[%c(PBNotification) alloc] init];
    [notification setSender: @"Notification"];
    [notification setSubject: sender];
    [notification setBody: body];
    [MSHookIvar<PBWatch*>(self, "_watch") sendNotification: notification];
    NSLog(@"pebbleNotifierReceivedNotification: notification queued");
}

static char const * const keyMessagingCenter = "_pn_messagingCenter";

- (id)initWithAccessory:(id)arg1
{
  CPDistributedMessagingCenter *messagingCenter;
  messagingCenter = objc_getAssociatedObject(self, keyMessagingCenter);
  if (messagingCenter == NULL)
  {
    messagingCenter = [[CPDistributedMessagingCenter centerNamed:@"tw.itsZero.PebbleNotifier.MessagingCenter"] retain];
    [messagingCenter registerForMessageName:@"newNotification" target:self selector:@selector(pebbleNotifierReceivedNotificationNamed:WithUserInfo:)];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{}];
      [messagingCenter runServerOnCurrentThread];
      while (1) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
      }
    });
    objc_setAssociatedObject(self, keyMessagingCenter, messagingCenter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    NSLog(@"PebbleNotifier: register observer");
  }
  return %orig;
}

%end

%hook UIApplication

- (void)endBackgroundTask:(unsigned int)backgroundTaskId
{
}

%end

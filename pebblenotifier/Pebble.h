@class PBWatch;

@interface PBWatch
- (void)sendNotification:(id)arg1;
@end

@interface PBNotification : NSObject
{
    NSString *_sender;
    int _type;
    NSString *_body;
    NSString *_subject;
}

@property(retain, nonatomic) NSString *subject; // @synthesize subject=_subject;
@property(retain, nonatomic) NSString *body; // @synthesize body=_body;
@property(nonatomic) int type; // @synthesize type=_type;
@property(retain, nonatomic) NSString *sender; // @synthesize sender=_sender;
- (id)protocolMessageData;

@end

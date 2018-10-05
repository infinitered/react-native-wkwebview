#import "NSHTTPCookie+SetCookie.h"

@implementation NSHTTPCookie(SetCookie)
- (NSString*)formatForSetCookie {
    NSString* name = [self name];
    NSString* value = [self value];
    NSString* domain = [self domain];
    NSString* path = [self path];
    NSString* isSecure = [self isSecure] ? @"Secure;" : @"";

    NSDateFormatter* rfc7231DateFormatter = [[NSDateFormatter alloc] init];
    NSLocale* posixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [rfc7231DateFormatter setLocale:posixLocale];
    [rfc7231DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    rfc7231DateFormatter.dateFormat = @"EEE, dd MMM yyyy HH mm ss 'GMT'";
    NSDate* expiresDate = [self expiresDate];
    NSString* formattedExpiresDate = [self expiresDate] ? [NSString stringWithFormat:@"Expires=%@;", [rfc7231DateFormatter stringFromDate:expiresDate]] : @"";

    return [NSString stringWithFormat:@"%@=%@; Domain=%@; Path=%@; %@%@ ", name, value, domain, path, formattedExpiresDate, isSecure];
}
@end
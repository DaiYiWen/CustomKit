//
//  StringJson.h
//

#import <Foundation/Foundation.h>

@interface StringJson : NSObject
+(NSString*)getJSON:(NSMutableDictionary*)dic;


/**将NSString转化为NSArray**/
+(NSArray*)arrValue:(NSString*)str;

/**将NSString转化为NSDictionary**/
+(NSDictionary*)dicValue:(NSString*)str;

/**将Nsdata转化为NSDictionary**/
+(NSDictionary*)dicValueData:(NSData*)data;

/**将NSDictionary转化为NSString**/
+(NSString*)dicString:(NSDictionary*)dic;

/**将NSArray转化为NSString**/
+(NSString*)arrString:(NSArray*)jsonarray;

/**JSON字符串转化为字典**/
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

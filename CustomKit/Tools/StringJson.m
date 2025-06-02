//
//  StringJson.m
//

#import "StringJson.h"

@implementation StringJson

+(NSString*)getJSON:(NSMutableDictionary*)dic{

    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                            options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return str;
}

/**将NSString转化为NSArray**/
+(NSArray*)arrValue:(NSString*)str
{
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

/**将NSString转化为NSDictionary**/
+(NSDictionary*)dicValue:(NSString*)str
{
    __autoreleasing NSError* error = nil;

    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSDictionary *)dicValueData:(NSData*)data{
    __autoreleasing NSError* error = nil;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**将NSArray转化为NSString**/
+(NSString*)arrString:(NSArray*)jsonarray
{
    NSError* error = nil;
    NSData *result = [NSJSONSerialization dataWithJSONObject:jsonarray
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    
    NSString *jsonString = [[NSString alloc] initWithData:result
                                                 encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

/**将NSDictionary转化为NSString**/
+(NSString*)dicString:(NSDictionary*)dictB
{
    NSError *error = nil;
    NSData *jsonData = nil;
    if (!self) {
      return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dictB enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
      NSString *keyString = nil;
      NSString *valueString = nil;
      if ([key isKindOfClass:[NSString class]]) {
        keyString = key;
      }else{
        keyString = [NSString stringWithFormat:@"%@",key];
      }

      if ([obj isKindOfClass:[NSString class]]) {
        valueString = obj;
      }else{
        valueString = [NSString stringWithFormat:@"%@",obj];
      }

      [dict setObject:valueString forKey:keyString];
    }];
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] == 0 || error != nil) {
      return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


@end

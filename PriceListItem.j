
@import <Foundation/CPObject.j>

@implementation PriceListItem : CPObject
{
    CPString name @accessors;
    int price @accessors;
}

- (id)initWithName:(CPString)aName price:(int)aPrice
{
    if (self = [super init])
    {
        [self setName:aName];
        [self setPrice:aPrice];
    }
    return self;
}

@end

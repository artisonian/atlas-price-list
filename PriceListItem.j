
@import <Foundation/CPObject.j>

@implementation PriceListItem : CPObject
{
    CPString name @accessors;
    int price @accessors; // Price is stored as an integer (i.e. price in pennies)
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

- (id)init
{
    [self initWithName:@"" price:0];
}

@end

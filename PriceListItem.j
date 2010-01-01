
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

- (id)init
{
    [self initWithName:@"" price:0];
}

@end

/*
var PriceItemNameKey = @"PriceItemName",
    PriceItemPriceKey = @"PriceItemPrice";

@implementation PriceListItem (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder
{
    console.log([CPString stringWithFormat:@"decoding PriceListItem..."]);
    self = [super initWithCoder:aCoder];
    if (self) {
        // unarchive data objects and outlets
        [self setName:[aCoder decodeObjectForKey:PriceItemNameKey]];
        [self setPrice:[aCoder decodeObjectForKey:PriceItemPriceKey]];
    }
    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    console.log([CPString stringWithFormat:@"encoding PriceListItem..."]);
    [super encodeWithCoder:aCoder];

    // Archive data objects and outlets
    [aCoder encodeObject:[self name] forKey:PriceItemNameKey];
    [aCoder encodeObject:[self price] forKey:PriceItemPriceKey];
}

@end
*/

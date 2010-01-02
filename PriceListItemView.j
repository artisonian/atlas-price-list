
@import <AppKit/CPView.j>
@import "PriceListItem.j"

@implementation PriceListItemView : CPView
{
    PriceListItem priceItem;
    @outlet CPTextField nameLabel;
    @outlet CPTextField priceLabel;
}

- (void)setRepresentedObject:(id)anObject
{
    if (!priceItem) {
        priceItem = [[PriceListItem alloc] initWithName:[anObject name] price:[anObject price]];
    }
    
    [nameLabel setFont:[CPFont boldSystemFontOfSize:14.0]];

    [priceLabel setFont:[CPFont boldSystemFontOfSize:12.0]];
    [priceLabel setTextColor:[CPColor whiteColor]];
    [priceLabel setAlignment:CPCenterTextAlignment];

    [nameLabel setStringValue:[priceItem name]];
    [priceLabel setStringValue:[priceItem price] / 100.0]; // to display in dollars

    var bgImage = [[CPImage alloc]
            initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:@"row_bg.png"]];
    [self setBackgroundColor:[CPColor colorWithPatternImage:bgImage]];
}

@end

var PriceListItemKey = @"PriceListItem",
    PriceListNameLabelKey = @"PriceListNameLabel",
    PriceListPriceLabelKey = @"PriceListPriceLabel";

@implementation PriceListItemView (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder
{
    //console.log([CPString stringWithFormat:@"decoding PriceListItemView..."]);
    self = [super initWithCoder:aCoder];
    if (self) {
        // unarchive data objects and outlets
        priceItem = [aCoder decodeObjectForKey:PriceListItemKey];
        nameLabel = [aCoder decodeObjectForKey:PriceListNameLabelKey];
        priceLabel = [aCoder decodeObjectForKey:PriceListPriceLabelKey];
    }
    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    //console.log([CPString stringWithFormat:@"encoding PriceListItemView..."]);
    [super encodeWithCoder:aCoder];

    // Archive data objects and outlets
    [aCoder encodeObject:priceItem forKey:PriceListItemKey];
    [aCoder encodeObject:nameLabel forKey:PriceListNameLabelKey];
    [aCoder encodeObject:priceLabel forKey:PriceListPriceLabelKey];
}

@end

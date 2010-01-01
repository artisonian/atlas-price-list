
@import <AppKit/CPView.j>


@implementation PriceListItemView : CPView
{
}

- (void)setRepresentedObject:(id)anObject
{
    var bgImage = [[CPImage alloc]
            initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:@"row_bg.png"]];
    [self setBackgroundColor:[CPColor colorWithPatternImage:bgImage]];
}

@end

@implementation PriceListItemView (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // unarchive data objects and outlets
    }
    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    // Archive data objects and outlets
}

@end

/*
 * AppController.j
 * PriceList
 *
 * Created by Leroy Campbell on Janurary 1, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "PriceListItemView.j"
@import "PriceListItem.j"

@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPCollectionView priceList;
	CPURLConnection cometTestConnection;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    CPLogRegister(CPLogConsole);

    [[theWindow contentView] setBackgroundColor:[CPColor colorWithWhite:0.8 alpha:1.0]];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.
    
    // [priceList setBackgroundColors:[CPColor colorWithRed:0.47 green:0.42 blue:0.4 alpha:1.0]];
    [priceList setMinItemSize:CGSizeMake(405.0, 30.0)];
    [priceList setMaxItemSize:CGSizeMake(2000.0, 30.0)];
    [priceList setMaxNumberOfColumns:1];
    [priceList setVerticalMargin:0.0];
    [self loadTestData];

	cometTestConnection = [CPURLConnection connectionWithRequest:[CPURLRequest requestWithURL:[CPURL URLWithString:@"/test"]] delegate:self];
}

- (void)loadTestData
{
    // Prices are specified in integers (penny amounts)
    var priceItems = [CPArray arrayWithObjects:
            [[PriceListItem alloc] initWithName:@"Deluxe cookies" price:399],
            [[PriceListItem alloc] initWithName:@"Yummy cheesecake" price:1299],
            [[PriceListItem alloc] initWithName:@"Tasty brownies" price:799]];
    [priceList setContent:priceItems];
    //console.log([CPString stringWithFormat:@"price list content: %@", [priceList content]]);
}

- (@action)addToPriceList:(id)sender
{
    //console.log("addToPriceList:");
    var content = [priceList content];
    var newPriceItem = [[PriceListItem alloc]
            initWithName:@"Generic dessert"
            price:Math.ceil(Math.random() * 1999)]; // Price between 1 and 2000 pennies
    [priceList setContent:[content arrayByAddingObject:newPriceItem]];
    // [priceList reload];
}

// CPURLRequest Delegate Methods
- (void)connection:(CPURLConnection)connection didReceiveData:(CPString)data
{
	CPLog(data);
	var jsObject = [data objectFromJSON];
	CPLog(jsObject);
	if (jsObject.message) {
		CPLog(jsObject.message);
	} else if (jsObject.results) {
		var newItems = [CPArray array];
		for (var i = 0, j = jsObject.results.length; i < j; i++) {
			CPLog(jsObject.results[i]);
			var newPriceItem = [[PriceListItem alloc]
		            initWithName:jsObject.results[i].name
		            price:jsObject.results[i].price];
			[newItems addObject:newPriceItem];
		}
		if ([newItems count] > 0) {
			[priceList setContent:[[priceList content] arrayByAddingObjectsFromArray:newItems]];
		}
	}
}

- (void)connection:(CPURLConnection)connection didFailWithError:(id)error
{
	CPLog('Connection failed');
}

- (void)connectionDidFinishLoading:(CPURLConnection)connection
{
	cometTestConnection = [CPURLConnection connectionWithRequest:[CPURLRequest requestWithURL:[CPURL URLWithString:@"/test"]] delegate:self];
}

@end

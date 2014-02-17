//
//  AppData.m
//  iTrade
//
//  Created by JBH-User on 26/08/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "AppData.h"
#import "Stock.h"
#import "SBJson.h"

@implementation AppData

static AppData *instance;
NSMutableArray *stocksPlistArray;

Stock *stock;
int i = -1;
NSMutableData *receivedData;

// --------------------

+(AppData *)sharedInstance{
    if(instance == nil){
        instance = [[AppData alloc] init];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate]; // or importing appData to appDelegate
        instance.context = appDelegate.managedObjectContext;
        
        instance.user = [[User alloc] USinitUser];
        instance.user.userName = [User USbringUserNameFromUserDefaults]; // setting property for future use
        
        NSMutableArray *array = [instance bringTableContentFromCoreDataByEntityName:@"Company"];
        if(array.count == 0){
            NSString *stocksPlistPath = [[NSBundle mainBundle] pathForResource:@"StocksPlist" ofType:@"plist"];
            stocksPlistArray = [NSMutableArray arrayWithContentsOfFile: stocksPlistPath]; // array of NSDictionary
            NSLog(@"%@", stocksPlistArray);
            [instance moveStocksDataToCoreDataFromPList:stocksPlistArray];
        }
        instance.stocksArray = [instance bringTableContentFromCoreDataByEntityName:@"Stock"]; // if Company is not empty neither does Stock
        
        instance.user.purchaseActionArray = [instance bringTableContentFromCoreDataByEntityName:@"PurchaseAction"];
        instance.user.saleActionArray = [instance bringTableContentFromCoreDataByEntityName:@"SaleAction"];
        [NSTimer scheduledTimerWithTimeInterval:10 target:instance selector:@selector(connectToServerForStockPriceUpdateWithNewPrice:) userInfo:nil repeats:YES];
    }
    return instance;
}

// --------------------
#pragma mark - notification center methods

-(void)connectToServerForStockPriceUpdateWithNewPrice:(NSString*)newPrice{
    if(i != -1){
        stock.price = @([newPrice floatValue]);
    }
    i++;
    if(i < self.stocksArray.count){
        stock = self.stocksArray[i];
        NSString *stockSign = stock.sign;
        NSString *urlString = [NSString stringWithFormat:@"http://www.google.com/finance/info?infotype=infoquoteall&q=%@", stockSign];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }else{
        i = -1;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stocksPriceUpdate" object:nil];
}

// call "server" for updat, update stocksArray, send notification on the update event
/*
-(void)updatePricesInStocksArray{
    int persentChange = [self connectToServerForPricesUpdate];
    for (Stock * stock in self.stocksArray) {
        CGFloat stockPrice = [stock.price floatValue];
        stockPrice += stockPrice * (persentChange/100.0);
        stock.price = [NSNumber numberWithFloat:stockPrice]; // stockPrice
    }
}

-(int)connectToServerForPricesUpdate{
    int priceChange = arc4random()%10-5;
    return priceChange;
}
*/

// --------------------
#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    receivedData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *receivedString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSString *jsonString = [receivedString stringByReplacingOccurrencesOfString:@"//" withString:@""];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *array =[parser objectWithString:jsonString];
    NSString *innerString = [array[0] valueForKey:@"l_cur"];
    NSLog(@"new price: %@", innerString);
    [instance connectToServerForStockPriceUpdateWithNewPrice:innerString];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@ %@", error.localizedDescription, error.userInfo);
    
}


// --------------------
#pragma mark - core data methods

// inserting stock data from plist to core data's Company and Stock entities
-(void)moveStocksDataToCoreDataFromPList:(NSMutableArray*)plistArray{
 for (NSDictionary *stockDictionary in plistArray){
     Company *company = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.context];
     company.name = stockDictionary[@"company_name"];
     company.logo = stockDictionary[@"company_logo"];
     Stock *stock = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:self.context];
     stock.company = company;
     stock.sign = stockDictionary[@"stock_sign"];
     stock.price = @([stockDictionary[@"stock_price"] floatValue]);

     NSError *error;
     [self.context save:&error];
    }
 }

// brings entity data from core data
-(NSMutableArray*)bringTableContentFromCoreDataByEntityName:(NSString*)entityName{ // also chacking if table exist
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:instance.context];
    [request setEntity:description];
    NSError *error;
    NSMutableArray *CDarray = [[instance.context executeFetchRequest:request error:&error]mutableCopy];
    return CDarray;
}


// save Purchase/Sale objects to core data located in related view controllers


@end

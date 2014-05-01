//
//  XMLParser.m
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "XMLParser.h"
#import "SicopRecepcionAppDelegate.h"
//#import "UserApp.h"

@implementation XMLParser
@synthesize nmClaseDatos;

- (XMLParser *) initXMLParser{
	[super init];
	appDelegate = (SicopRecepcionAppDelegate *)[[UIApplication sharedApplication] delegate];
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"results"]) {
		//Initialize the array.
		appDelegate.elementosXml = [[NSMutableArray alloc] init];
	}
	else if([elementName isEqualToString:@"result"]) {
		
        Class controllerClass = NSClassFromString(nmClaseDatos);
        datosParser = [[controllerClass alloc]init];
        
        //Si estamos parseando los datos del usuario
        if ([datosParser isKindOfClass:[UserApp class]]) {
            
            //[datosParser setValue:[[attributeDict objectForKey:@"IdEjecutivo"] stringValue]     forKey:@"IdEjecutivo"];
            //[datosParser setValue:[[attributeDict objectForKey:@"IdMarca"] stringValue] forKey:@"IdMarca"];
            //[datosParser setValue:[[attributeDict objectForKey:@"Marca"] stringValue] forKey:@"Marca"];
            //[datosParser setValue:[[attributeDict objectForKey:@"Servidor"] stringValue] forKey:@"Servidor"];
            //[datosParser setValue:[[attributeDict objectForKey:@"BaseDeDatos"] stringValue] forKey:@"BaseDeDatos"];
            //[datosParser setValue:[[attributeDict objectForKey:@"isTablet"] stringValue] forKey:@"isTablet"];
            
        [datosParser setValue: [[[attributeDict objectForKey:@"IdEjecutivo"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:@"IdEjecutivo"];
           
        [datosParser setValue: [[[attributeDict objectForKey:@"IdMarca"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:@"IdMarca"];
        [datosParser setValue: [[[attributeDict objectForKey:@"Marca"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:@"Marca"];
        [datosParser setValue: [[[attributeDict objectForKey:@"Servidor"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:@"Servidor"];
        [datosParser setValue: [[[attributeDict objectForKey:@"BaseDeDatos"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:@"BaseDeDatos"];
        [datosParser setValue: [[[attributeDict objectForKey:@"isTablet"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:@"isTablet"];
            
            
        }
		NSLog(@"Reading id value :%@", [[attributeDict objectForKey:@"PaginaWEB"] stringValue]);
	}
	
	NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
	NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"results"])
		return;
	
	// and release the object.
	if([elementName isEqualToString:@"result"]) {
		[appDelegate.elementosXml addObject:datosParser];
		[datosParser release];
	   	datosParser = nil;
   	}else
        [datosParser setValue:currentElementValue forKey:elementName];
	
	[currentElementValue release];
    currentElementValue = nil;
}

- (void) dealloc {
	
	//[datosParser release];
	//[currentElementValue release];
	[super dealloc];
}

@end

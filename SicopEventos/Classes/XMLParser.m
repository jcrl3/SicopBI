//
//  XMLParser.m
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "XMLParser.h"
#import "SurveyAppDelegate.h"
#import "Autos.h"
#import "Ejecutivo.h"
#import "Evento.h"
#import "Distribuidor.h"
#import "EjecutivoComplemento.h"

@implementation XMLParser
@synthesize nmClaseDatos;  

- (XMLParser *) initXMLParser{
	[super init];
	appDelegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"results"]) {
//      	if([elementName isEqualToString:@"results"]) {
		//Inicializamos el arreglo que contendra los objetos que se generaran a partir de los resultados del servicioo web.
		appDelegate.elementosParser = [[NSMutableArray alloc] init];
	}

	//else if([elementName isEqualToString:@"result"]) {
      else if([elementName isEqualToString:@"result"]) {
		
      Class controllerClass = NSClassFromString(nmClaseDatos);
      aRegistro = [[controllerClass alloc] init];
      
      //Si estamos parseando los datos del usuario
      if ([aRegistro isKindOfClass:[Autos class]]) {
         
         [aRegistro setValue:[[attributeDict objectForKey:@"idAuto"] stringValue] forKey:@"idAuto"];
         [aRegistro setValue:[[attributeDict objectForKey:@"nombreAuto"] stringValue] forKey:@"nombreAuto"];
         
      }
      //Si estamos parseando los datos de los ejecutivos
      if ([aRegistro isKindOfClass:[Ejecutivo class]]) {
         [aRegistro setValue:[[attributeDict objectForKey:@"IdEjecutivo"] stringValue] forKey:@"idEjecutivo"];
      }


         //Si estamos parseando los datos de los ejecutivos
         if ([aRegistro isKindOfClass:[EjecutivoComplemento class]]) {
            [aRegistro setValue:[[attributeDict objectForKey:@"Nombre"] stringValue] forKey:@"nombre"];
            [aRegistro setValue:[[attributeDict objectForKey:@"idDistribuidor"] stringValue] forKey:@"idDistribuidor"];             
         }

         
         
      if ([aRegistro isKindOfClass:[Evento class]]) {
        
         [aRegistro setValue:[[attributeDict objectForKey:@"idEvento"] stringValue] forKey:@"idEvento"];
         [aRegistro setValue:[[attributeDict objectForKey:@"nombreEvento"] stringValue] forKey:@"nombreEvento"];
         [aRegistro setValue:[[attributeDict objectForKey:@"inicioEvento"] stringValue] forKey:@"inicioEvento"];
         [aRegistro setValue:[[attributeDict objectForKey:@"finEvento"] stringValue] forKey:@"finEvento"];
         [aRegistro setValue:[[attributeDict objectForKey:@"idFuente"] stringValue] forKey:@"idFuente"];
         [aRegistro setValue:[[attributeDict objectForKey:@"idSubcampana"] stringValue] forKey:@"idSubcampana"];
         [aRegistro setValue:[[attributeDict objectForKey:@"disclaimer"] stringValue] forKey:@"disclaimer"];
		 [aRegistro setValue:[[attributeDict objectForKey:@"idMarca"] stringValue] forKey:@"idMarca"];
       }
         
      if ([aRegistro isKindOfClass:[Distribuidor class]]){
            [aRegistro setValue:[[attributeDict objectForKey:@"idDistribuidor"] stringValue] forKey:@"idDistribuidor"];
            [aRegistro setValue:[[attributeDict objectForKey:@"nombreDistribuidor"] stringValue] forKey:@"nombreDistribuidor"];
      }
	}
	
	NSLog(@"Processing Element: %@", [attributeDict objectForKey:@"nombreEvento"]);
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
		[appDelegate.elementosParser addObject:aRegistro];
		[aRegistro release];
	   	aRegistro = nil;
   	}else 
		 [aRegistro setValue:currentElementValue forKey:elementName];
	
	[currentElementValue release];
	 currentElementValue = nil;
}

- (void) dealloc {
	
	//[aRegistro release];
	//[currentElementValue release];
	[super dealloc];
}

@end

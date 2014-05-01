
#import <UIKit/UIKit.h>

@class SurveyAppDelegate, Autos, Ejecutivo, Evento, Distribuidor, EjecutivoComplemento;

@interface XMLParser : NSObject {

	NSMutableString *currentElementValue;
	NSString *nmClaseDatos;
	SurveyAppDelegate *appDelegate;
   NSObject *aRegistro; 
}
@property (nonatomic,retain)  NSString *nmClaseDatos;
- (XMLParser *) initXMLParser;

@end

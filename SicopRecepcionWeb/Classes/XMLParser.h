
#import <UIKit/UIKit.h>

@class SicopRecepcionAppDelegate;

@interface XMLParser : NSObject {
    
	NSMutableString *currentElementValue;
	NSString *nmClaseDatos;
	NSObject *datosParser;
    
    SicopRecepcionAppDelegate *appDelegate;
    
}
@property (nonatomic,retain)  NSString *nmClaseDatos;
- (XMLParser *) initXMLParser;

@end

//
//  DetailViewController.h
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 11/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAccess.h"
#import "datProspecto.h"
#import "ConfiguraEvento.h"
#import "DatAutos.h"
#import "DatEjecutivos.h"
#import "DatEvento.h"
#import "Error.h"
#import "DatDistribuidor.h"
#import "Distribuidor.h"
#import "Fechas.h"
#import "Disclaimer.h"
#import "SurveyAppDelegate.h"
#import "DatCodigoPostal.h"
#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC                 @"1234567890"
#define ALPHA_NUMERIC           ALPHA NUMERIC

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate,UITextFieldDelegate, UITextViewDelegate> {

   UIPopoverController  *popoverController;
   UIToolbar			*toolbar;
   NSDictionary			*detailItem;
   UILabel				*numeroRegistros;
   UILabel				*idRegistroActual;
   UILabel				*disclaimer;
   UILabel				*mensajeMailLabel;
   UILabel				*mensajeEventoNoConfigurado;

   UITextField			*primerNombreTextField;
   UITextField			*segundoNombreTextField;
   UITextField			*tercerNombreTextField;
   UITextField			*telefonoTextField;
   UITextField			*correoTextField;
   UITextField			*codigoPostal;

   IBOutlet UITextField			*telefonoMovilTextField;
   IBOutlet UIPickerView		*pickerView;
   IBOutlet UIPickerView		*ejecutivoAsignado;
   IBOutlet UISegmentedControl	*hizoPrueba;
   IBOutlet UISegmentedControl	*deseaPrueba;
   IBOutlet UISegmentedControl	*deseaCotizacion;
   IBOutlet UISegmentedControl	*interesadoAccesorios;
   IBOutlet UISegmentedControl	*deseaSerContactado;
   IBOutlet UIButton			*botonDisclaimer;
   IBOutlet UIImageView			*imagenStatusRed;
   IBOutlet UILabel				*urlLabel;

	NSMutableArray				*arrayLineas;
	NSMutableArray				*arrayEjecutivos;
	UIButton					*infoButton;
	UIPopoverController			*infoPopover;

	Evento						*evento;

@private
  DatCodigoPostal   *baseDeCps;
	
}

@property (nonatomic,retain)  IBOutlet UIToolbar			*toolbar;
@property (nonatomic,retain)  NSDictionary					*detailItem;
@property (nonatomic,retain)  IBOutlet UITextField			*primerNombreTextField;
@property (nonatomic,retain)  IBOutlet UITextField			*segundoNombreTextField;
@property (nonatomic,retain)  IBOutlet UITextField			*tercerNombreTextField;
@property (nonatomic,retain)  IBOutlet UITextField			*telefonoTextField;
@property (nonatomic,retain)  IBOutlet UITextField			*correoTextField;
@property (nonatomic,retain)  IBOutlet UITextField			*telefonoMovilTextField;
@property (nonatomic,retain)  IBOutlet UITextView			*observaciones;
@property (nonatomic,retain)  IBOutlet UIPickerView			*pickerView;
@property (nonatomic,retain)  IBOutlet UIPickerView			*ejecutivoAsignado;
@property (nonatomic,retain)  IBOutlet UISegmentedControl	*hizoPrueba;
@property (nonatomic,retain)  IBOutlet UISegmentedControl	*deseaPrueba;
@property (nonatomic,retain)  IBOutlet UISegmentedControl	*deseaCotizacion;
@property (nonatomic,retain)  IBOutlet UISegmentedControl	*interesadoAccesorios;
@property (nonatomic,retain)  IBOutlet UISegmentedControl	*deseaSerContactado;
@property (nonatomic,retain)  IBOutlet UIButton				*infoButton;
@property (nonatomic,retain)  IBOutlet UIPopoverController	*infoPopover;
@property (nonatomic,retain)  IBOutlet UITextField			*codigoPostal;
@property (nonatomic,retain)  IBOutlet UILabel				*mensajeMailLabel;
@property (nonatomic,retain)  IBOutlet UILabel				*numeroRegistros;
@property (nonatomic,retain)  IBOutlet UILabel				*mensajeEventoNoConfigurado;
@property (nonatomic,retain)  IBOutlet UILabel				*idRegistroActual;
@property (nonatomic,retain)  IBOutlet UILabel				*disclaimer;
@property (nonatomic,retain)  NSMutableArray				*arrayLineas;
@property (nonatomic,retain)  NSMutableArray				*arrayEjecutivos;
@property (nonatomic,retain)  IBOutlet UIButton				*botonDisclaimer;
@property (nonatomic,retain)  IBOutlet UIImageView			*imagenStatusRed;
@property (nonatomic,retain)  Evento						*evento;
@property (nonatomic, retain) IBOutlet UILabel				*urlLabel;



-(IBAction)configuraEvento:(id)sender;
-(IBAction)clearSurvey:(id)sender;
-(IBAction)addSurvey:(id)sender;
-(IBAction)showInfo:(id)sender;
-(IBAction)hizoPruebaDemo:(id)sender;
-(void)handleSegmentClick:(id)sender;
-(void) limpiaCampos;
-(IBAction)doneEditing:(id)sender;
-(IBAction)backgroundClick:(id)sender;
-(void) showVentanaConfigEvento;
-(void) cargaConfiguracionEvento;
-(IBAction) showDisclaimer:(id)sender;
-(void) checaStatusRed:(NSNotification *)notice;

@end

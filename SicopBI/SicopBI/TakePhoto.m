//
//  TakePhoto.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 11/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TakePhoto.h"
#import "AppDelegate.h"
@implementation TakePhoto{

	
}

+(UIImage*)TakePhotoFromUIView: (UIView*) pView{
	// Obtenemos el delegado de nuestra App para acceder al objeto UIWindow
	AppDelegate *miDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
	// Iniciamos un contexto del tamaño que nuestro Window (haciendo la comprobación por
	// si la pantalla es Retina)
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(miDelegate.window.bounds.size, NO, [UIScreen mainScreen].scale);
	} else {
		UIGraphicsBeginImageContext(miDelegate.window.bounds.size);
	}
 
	// Renderizamos la capa que contiene la ventana en nuestro contexto
//	[miDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
	
	[pView.layer renderInContext:UIGraphicsGetCurrentContext()];
 
	// Guardamos en un objeto Image lo almacenado ahora mismo en el contexto
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	// FInalizamos el contexto
	UIGraphicsEndImageContext();
 
	// Pintamos en un UIImageView de nuestro controlador la imagen capturada
	return image;
}

@end
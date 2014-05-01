//
//  CodigoPostal.m
//  SicopEventos
//
//  Created by JUAN RAMIREZ on 27/02/14.
//  Copyright (c) 2014 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DatoLegal.h"

@implementation DatoLegal

-(id) init
{
	if (self == [super init])
	 {
		textoLegal=@"";
	 }
	return self;
}

-(NSString*) getTextoLegal:(NSString*) pIdMarca{
	
	
	if ([pIdMarca isEqualToString:@"153"]) {
		textoLegal=@"                                                 PROSPECTOS \n\n" \
		"                                      Aviso de Privacidad Simplificado\n\n" \
		"NISSAN MEXICANA, S. A. DE C. V., (NMEX) con domicilio en Insurgentes Sur 1958, Colonia Florida, Delegación Álvaro Obregón, C.P. 01030, México Distrito " \
		"Federal,informa que la aportación que haga de sus datos personales se entenderá en carácter de cliente potencial  y la misma constituye la aceptación de los términos y condiciones del presente aviso. \n\n" \
		  
		"En consecuencia autoriza a NMEX al tratamiento de sus datos personales para (i) realizar actividades de mercadeo y prospección, (ii) ofrecerle productos e "\
		"información, (iii) realizar análisis estadísticos y de mercado, (iv) invitarle a eventos y pruebas de manejo (v) informarle de promociones y lanzamientos, (vi)" \
		"mantener actualizados nuestros registros; todo ello en relación a los productos o servicios  de  NMEX y sus socios de negocios.\n\n" \
		"Dado que la aportación de sus datos personales se hace en carácter de cliente potencial, las finalidades primordiales para las cuales se usara su " \
		"información es la mercadotecnia, publicidad y prospección de las formas en el párrafo que antecede.\n\n" \
		
		"Usted podrá manifestar su negativa al uso de su información mediante correo electrónico dirigido a proteccióndatosnissan@nrfm.com.mx  conforme a lo señ" \
		"a lado en el aviso de privacidad integral ubicado en la página http://www.nissan.com.mx/legales.\n\n\n" \
		"                                                           CLIENTES\n\n" \
		"                                       Aviso de Privacidad Simplificado\n\n" \
		"NISSAN MEXICANA, S. A. DE C. V., (NMEX) con domicilio en Insurgentes Sur 1958, Colonia Florida, Delegación Álvaro Obregón, C.P. 01030, México Distrito " \
		"Federal, le informa que la aportación que haga de sus datos personales se entenderá en carácter de cliente potencial  y la misma constituye la" \
		"aceptación de los términos y condiciones del presente aviso.\n\n" \
		"En consecuencia autoriza a NMEX al tratamiento de sus datos personales para (i) hacer efectiva la garantía (ii) proveerle de un bien o servicio (iii)" \
		"informarle de campañas de servicios (iv) realizar actividades de mercadeo y prospección, (v) ofrecerle productos e información, (vi) realizar análisis" \
		"estadísticos y de mercado, (vii) invitarle a eventos y pruebas de manejo (viii) informarle de promociones y lanzamientos, (ix) mantener " \
		"actualizados nuestros registros; todo ello en relación a los productos o servicios  de  NMEX y sus socios de negocios.\n\n" \
		"Las finalidades primordiales para las cuales se usara su información y las cuales dan origen a nuestra relación son las mencionadas en los puntos (i)(ii)"
		\
		"(iii)(iv), siendo que la (v)(vi)(vii)(viii)(ix) no son necesarias para mantener nuestra relación jurídica.\n\n" \
		"Usted podrá manifestar su negativa al uso de su información para los puntos (v)(vi)(vii)(viii)(ix)  mediante correo electrónico dirigido a protección" \
		"datosnissan@nrfm.com.mx  conforme a lo señalado en el aviso de privacidad integral ubicado en la página http://www.nissan.com.mx/legales.\n";
	}else{
		textoLegal=@" SICOP CONSULTING en nombre del distribuidor que cuenta con las licencias y derechos de uso correspondiente de su sistemas de administración de relación con prospectos y clientes mantendrá en confidencialidad la información proporcionada por usted al ingreso de esta aplicación, así mismo le comentamos que los datos ingresados serán consultados única y exclusivamente por el grupo de profesionales del Distribuidor durante su proceso de compra del vehículo y de propiedad del mismo.\n\n"\
		"SICOP CONSULTING SA DE CV, con domicilio en Avenida Santa Fe 495 16-02 Cruz Manca C.P. 05349, D.F., le avisa que, de conformidad con la Ley Federal de Protección de Datos Personales en Posesión de los Particulares, sus datos personales, los cuales pueden incluir datos sensibles, referidos en los documentos requisitados por usted, los que se obtengan y aquellos que generamos, con motivo de la gestión de su proceso de compra de un vehículo y de propiedad del mismo, se tratarán confidenciales.\n\n"
		"Sus datos personales no serán transferidos a terceros para fines distintos a los antes mencionados, salvaguardando la privacidad de los mismos.\n\n"
		"El ejercicio de los derechos de acceso, rectificación, cancelación y oposición, podrá efectuarse por escrito en el domicilio antes mencionado, de acuerdo al precitado ordenamiento."\
		"La revocación del consentimiento sobre el tratamiento de sus datos personales, cuando resulte procedente, podrá solicitarlo por escrito en el domicilio de esta entidad o simplemente eliminando esta aplicación de su dispositivo.";
	}
	return textoLegal;
}


- (void)dealloc {
	textoLegal=nil;
  	[super dealloc];
}
@end

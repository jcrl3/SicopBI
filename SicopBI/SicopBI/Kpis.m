//
//  Kpis.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 26/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "Kpis.h"

@implementation Kpis{
	
}
@synthesize idDistribuidor;
@synthesize idClientePIP;
@synthesize Distribuidor;
@synthesize Marca;
@synthesize Grupo;
@synthesize Plaza;
@synthesize Region;
@synthesize Zona;
@synthesize Estado;
@synthesize Municipio;
@synthesize Pais;
@synthesize Prospectos;
@synthesize ProspectosPiso;
@synthesize ProspectosReactivados;
@synthesize ProspectosInactivos;
@synthesize ProspectosInactivosPiso;
@synthesize ProspectosRechazados;
@synthesize Seguimientos;
@synthesize SeguimientosProgramados;
@synthesize SeguimientosCumplidos;
@synthesize SeguimientosCumplidosExitosos;
@synthesize ProspectosConPosibilidadDeDemo;
@synthesize ProspectosConDemo;
@synthesize ProspectosConDemoPiso;
@synthesize Demostraciones;
@synthesize DemostracionesPiso;
@synthesize Cotizaciones;
@synthesize CotizacionesPiso;
@synthesize VentasFacturadas;
@synthesize VentasEntregadas;
@synthesize VentasFacturadasPiso;
@synthesize VentasEntregadasPiso;
@synthesize VentasFacturadasDemo;
@synthesize VentasEntregadasDemo;
@synthesize VelocidadConversionFacturadas;
@synthesize VelocidadConversionEntregadas;
@synthesize ProspectosRecibidos;
@synthesize SeguimientosProgramadosPiso;
@synthesize SeguimientosProgramadosRecepcion;
@synthesize SeguimientosProgramadosLeads;
@synthesize Leads;
@synthesize LeadsInactivos;
@synthesize DemostracionesLeads;
@synthesize VentasFacturadasLeads;
@synthesize VentasEntregadasLeads;
@synthesize ProspectosInactivosTotal;
@synthesize ProspectosInactivosPisoTotal;
@synthesize LeadsInactivosTotal;
@synthesize ProspectosRechazadosPiso;
@synthesize ProspectosRechazadosLeads;
@synthesize prospectosventasentregadasmes;
@synthesize prospectosventasfacturadasmes;
@synthesize Linea;
@synthesize MarcaLinea;
@synthesize Segmento;
@synthesize Tipo;
@synthesize IdFecha;
@synthesize Fecha;
@synthesize Ano;
@synthesize Mes;
@synthesize DiaDelAno;
@synthesize DiaDelMes;
@synthesize DiaSemana;
@synthesize SemanaDelAno;
@synthesize NombreDia;
@synthesize NombreDiaCorto;
@synthesize NombreMes;
@synthesize NombreMesCorto;
@synthesize Trimestre;
@synthesize Semestre;
@synthesize IdEjecutivo;
@synthesize Ejecutivo;
@synthesize FuenteInformacion;
@synthesize Status;
@synthesize Subcampana;
@synthesize TipoCompra;
@synthesize TipoVenta;
@synthesize CierreVenta;
@synthesize TipoPrimerContacto;


- (instancetype)init
{
	self = [super init];
	if (self) {
		self.idDistribuidor=@"";
		self.idClientePIP=@"";
		self.Distribuidor=@"";
		self.Marca=@"";
		self.Grupo=@"";
		self.Plaza=@"";
		self.Region=@"";
		self.Zona=@"";
		self.Estado=@"";
		self.Municipio=@"";
		self.Pais=@"";
		self.Prospectos=@"0";
		self.ProspectosPiso=@"0";
		self.ProspectosReactivados=@"0";
		self.ProspectosInactivos=@"0";
		self.ProspectosInactivosPiso=@"0";
		self.ProspectosRechazados=@"0";
		self.Seguimientos=@"0";
		self.SeguimientosProgramados=@"0";
		self.SeguimientosCumplidos=@"0";
		self.SeguimientosCumplidosExitosos=@"0";
		self.ProspectosConPosibilidadDeDemo=@"0";
		self.ProspectosConDemo=@"0";
		self.ProspectosConDemoPiso=@"0";
		self.Demostraciones=@"0";
		self.DemostracionesPiso=@"0";
		self.Cotizaciones=@"0";
		self.CotizacionesPiso=@"0";
		self.VentasFacturadas=@"0";
		self.VentasEntregadas=@"0";
		self.VentasFacturadasPiso=@"0";
		self.VentasEntregadasPiso=@"0";
		self.VentasFacturadasDemo=@"0";
		self.VentasEntregadasDemo=@"0";
		self.VelocidadConversionFacturadas=@"0";
		self.VelocidadConversionEntregadas=@"0";
		self.ProspectosRecibidos=@"0";
		self.SeguimientosProgramadosPiso=@"0";
		self.SeguimientosProgramadosRecepcion=@"0";
		self.SeguimientosProgramadosLeads=@"0";
		self.Leads=@"0";
		self.LeadsInactivos=@"0";
		self.DemostracionesLeads=@"0";
		self.VentasFacturadasLeads=@"0";
		self.VentasEntregadasLeads=@"0";
		self.ProspectosInactivosTotal=@"0";
		self.ProspectosInactivosPisoTotal=@"0";
		self.LeadsInactivosTotal=@"0";
		self.ProspectosRechazadosPiso=@"0";
		self.ProspectosRechazadosLeads=@"0";
		self.prospectosventasentregadasmes=@"0";
		self.prospectosventasfacturadasmes=@"0";
		self.Linea=@"";
		self.MarcaLinea=@"";
		self.Segmento=@"";
		self.Tipo=@"";
		self.IdFecha=@"0";
		self.Fecha=@"";
		self.Ano=@"0";
		self.Mes=@"0";
		self.DiaDelAno=@"0";
		self.DiaDelMes=@"0";
		self.DiaSemana=@"0";
		self.SemanaDelAno=@"0";
		self.NombreDia=@"";
		self.NombreDiaCorto=@"";
		self.NombreMes=@"";
		self.NombreMesCorto=@"";
		self.Trimestre=@"0";
		self.Semestre=@"0";
		self.IdEjecutivo=@"";
		self.Ejecutivo=@"";
		self.FuenteInformacion=@"";
		self.Status=@"";
		self.Subcampana=@"";
		self.TipoCompra=@"";
		self.TipoVenta=@"";
		self.CierreVenta=@"";
		self.TipoPrimerContacto=@"";
	}
	return self;
}


@end

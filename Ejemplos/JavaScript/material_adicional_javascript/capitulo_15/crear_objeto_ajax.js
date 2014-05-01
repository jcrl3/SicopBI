/* Se define la función que se usará para instanciar objetos XMLHttpRequest */
	function crear_objeto_XMLHttpRequest() {
		try {
			objeto = new XMLHttpRequest();
		} catch(err1) {
			try {
				objeto = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (err2) {
				try {
					objeto = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (err3) {
					objeto = false;
				}
			}
		}
		return objeto;
	}
/* Aquí acaba la definición de la función que se usará para instaciar objetos XMLHttpRequest */

/* Esta sentencia se usará para invocar a la función que instancia objetos XMLHyypRequest. 
Cada vez que nuestros scripts necesiten uno de estos objetos, se crearán invocando a la 
función, asi: */
var objeto_AJAX = crear_objeto_XMLHttpRequest();

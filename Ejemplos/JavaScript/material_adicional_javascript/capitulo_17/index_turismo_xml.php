<html>
<head>
	<title>Uso de Ajax con XML</title>
	<script language="JavaScript" type="text/javascript">
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

	var objeto_AJAX = crear_objeto_XMLHttpRequest();

	function pedirClima() {
		var URL = "obtener_clima_xml.php?lista_de_paises=";
		URL += document.getElementById("lista_de_paises").value;
		objeto_AJAX.open("GET", URL, true);
		objeto_AJAX.onreadystatechange = mostrar_clima;
		objeto_AJAX.send(null);
	}

	function mostrar_clima() {
		if (objeto_AJAX.readyState == 4 && objeto_AJAX.status == 200) {
			document.getElementById("celda_de_resultados").innerHTML = objeto_AJAX.responseXML.getElementsByTagName("clima")[0].childNodes[0].nodeValue;
		}
	}
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
	<table width="400" border="0">
		<tr>
			<td align="left"> Seleccione un pa&iacute;s para ver su climatolog&iacute;a</td>
		</tr>
		<tr>
			<td align="left"><select name="lista_de_paises" size="4" id="lista_de_paises" onChange="javascript:pedirClima();">
				<option value="1">Espa&ntilde;a</option>
				<option value="2">Italia</option>
				<option value="3">Siberia</option>
				<option value="4">Sahara</option>
			</select></td>
		</tr>
		<tr><td align="left"><hr /></td></tr>
		<tr><td align="left" id="celda_de_resultados">&nbsp;</td></tr>
	</table>
</body>
</html>


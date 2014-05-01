<html>
<head>
<title>Nuestra Primera Aplicación Ajax</title>
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

/* La siguiente función se ejecuta cuando es invocada por un cambio en el control de la lista de paises. */
	function pedirClima(){
		var URL = "obtener_clima.php";
		objeto_AJAX.open("POST", URL, true);
		objeto_AJAX.onreadystatechange = muestraResultado;
		objeto_AJAX.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		objeto_AJAX.send("lista="+document.getElementById("lista").value);
	}

/* La siguiente función se ejecuta cuando se recibe una respuesta del servidor. */
	function muestraResultado(){
		if (objeto_AJAX.readyState == 4 && objeto_AJAX.status == 200) document.getElementById("celdaDeResultados").innerHTML = objeto_AJAX.responseText;
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>
<body>
<center>
	<table width="300" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="43" align="left" valign="top">Elija un pa&iacute;s de la lista para ver su climatolog&iacute;a:</td>
		</tr>
		<tr>
			<td height="88" align="left" valign="top"><select name="lista" size="4" id="lista" onChange="javascript:pedirClima();">
				<option value="1">Espa&ntilde;a</option>
				<option value="2">Italia</option>
				<option value="3">Siberia</option>
				<option value="4">Sahara</option>
			</select></td>
		</tr>
		<tr>
			<td height="43" align="left" valign="top">&nbsp;</td>
		</tr>
		<tr>
			<td height="150" align="left" valign="top" id="celdaDeResultados">&nbsp;</td>
		</tr>
	</table>
</center>
</body>
</html>


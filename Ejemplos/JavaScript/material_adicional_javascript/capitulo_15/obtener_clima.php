<?php
	$pais_elegido = $_REQUEST["lista"];
	switch($pais_elegido){
		case "1":
			$resultado = "Climatolog&iacute;a ib&eacute;rica";
			break;
		case "2":
			$resultado = "Climatolog&iacute;a mediterr&aacute;nea";
			break;
		case "3":
			$resultado = "Climatolog&iacute;a g&eacute;lida";
			break;
		case "4":
			$resultado = "Climatolog&iacute;a ardiente";
			break;
	}
	echo $resultado;
?>
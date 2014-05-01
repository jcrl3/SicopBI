<?php
	header ()
	$pais_elegido = $_REQUEST["lista"];
	$resultado = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>";
	$resultado .= "<climas>";
	switch($pais_elegido){
		case "1":
			$resultado .= "<clima>Climatología ibérica</clima>";
			break;
		case "2":
			$resultado .= "<clima>Climatología mediterránea</clima>";
			break;
		case "3":
			$resultado .= "<clima>Climatología gélida</clima>";
			break;
		case "4":
			$resultado .= "<clima>Climatología ardiente</clima>";
			break;
	}
	$resultado .= "</climas>";
	echo $resultado;
?>
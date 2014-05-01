<?php
	header('Content-Type: text/xml');
	$pais_elegido = $_REQUEST["lista_de_paises"];

	switch ($pais_elegido){
		case "1":
			$resultado = "<?xml version=\"1.0\"?><climas><clima>Climatolog&#237;a ib&#233;rica</clima></climas>";
			break;
		case "2":
			$resultado = "<?xml version=\"1.0\"?><climas><clima>Climatolog&#237;a mediterr&#225;nea</clima></climas>";
			break;
		case "3":
			$resultado = "<?xml version=\"1.0\"?><climas><clima>Climatolog&#237;a g&#233;lida</clima></climas>";
			break;
		case "4":
			$resultado = "<?xml version=\"1.0\"?><climas><clima>Climatolog&#237;a ardiente</clima></climas>";
			break;
	}
	echo $resultado;
?>



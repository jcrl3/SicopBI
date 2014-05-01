function trim(extremo)
{
    
   //Almacena la cadena en una variable temporal.
   var temporal = this;

   //Si no hay argumentos, se consideran ambos lados.
   if (arguments.length == 0)
   {
      extremo="a";
   }

   extremo=extremo.toLowerCase();

   //Si el argumento no es ninguno de los previstos, se consideran ambos lados.
   if (extremo != "a" && extremo!="i" && extremo!="d")
   {
      extremo="a";
   }
    
   //Recorta espacios por la izquierda.
   if (extremo == "i" || extremo == "a")
   {
      while (temporal.charAt(0) == " ")
      {
         temporal = temporal.substring(1);
      }
   }
    
   //Recorta espacios por la derecha.
   if (extremo == "d" || extremo == "a")
   {
      while (temporal.substr(temporal.length-1,1) == " ")
      {
         temporal = temporal.substring(0, temporal.length - 2);
      }
   }

   return temporal;
}

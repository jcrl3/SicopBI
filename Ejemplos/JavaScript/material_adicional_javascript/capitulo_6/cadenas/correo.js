function correo ()
{
   expresion=/^[a-z]([\w\.]*)@[a-z]([\w\.]*)\.[a-z]{2,3}$/;

   resultado = expresion.test(this);
   return resultado;

}

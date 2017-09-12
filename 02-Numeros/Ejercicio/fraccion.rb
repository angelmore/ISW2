require './numero'

class Fraccion < Numero

  def initialize(numerador,denominador)
    @numerador = numerador
    @denominador = denominador
  end

  def numerador
    @numerador
  end

  def denominador
    @denominador
  end

  def es_cero
    false
  end

  def es_uno
    false
  end

  def == un_objeto
    (un_objeto.kind_of? self.class) && (self.igual_a_fraccion un_objeto)
  end

  def igual_a_fraccion(una_fraccion)
    (@numerador*una_fraccion.denominador) == (@denominador*una_fraccion.numerador)
  end

  def hash
    @numerador.hash
  end

  def sumar_con_entero(sumando_entero)
    Fraccion.dividir (self.numerador + sumando_entero * self.denominador), self.denominador
  end

  def sumar_con_fraccion(sumando_fraccion)
    (numerador*sumando_fraccion.denominador+denominador*sumando_fraccion.numerador)/(denominador*sumando_fraccion.denominador)
  end

  def +(un_sumando)
    un_sumando.sumar_con_fraccion self
  end


  def multiplicar_con_fraccion(un_multiplicador)
	Fraccion.dividir (@numerador*un_multiplicador.numerador), (@denominador*un_multiplicador.denominador)
  end

  def multiplicar_con_entero(un_multiplicador)
  	Fraccion.dividir (numerador * un_multiplicador), denominador
  end

  def *(un_multiplicador)
  	un_multiplicador.multiplicar_con_fraccion self
  end

  def dividir_con_fraccion(un_dividendo)
  	Fraccion.dividir (un_dividendo.numerador*self.denominador), (un_dividendo.denominador*self.numerador)
  end

  def dividir_con_entero(un_dividendo)
      Fraccion.dividir un_dividendo*self.denominador, self.numerador
  end

  def /(un_divisor)
  	un_divisor.dividir_con_fraccion self #paso el dividendo
  end

  def self.dividir(un_dividendo,un_divisor)
    raise ZeroDivisionError.new if un_divisor.es_cero
    return un_dividendo if un_dividendo.es_cero

    maximo_comun_divisor = un_dividendo.maximo_comun_divisor_con un_divisor
    nuevo_numerador = un_dividendo.divison_entera maximo_comun_divisor
    nuevo_denominador = un_divisor.divison_entera maximo_comun_divisor

    return nuevo_numerador if nuevo_denominador.es_uno

    self.new(nuevo_numerador,nuevo_denominador)
  end

end

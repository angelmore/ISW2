  require './numero'

class Entero < Numero

  def initialize(value)
    @value = value
  end

  def es_cero
    @value == 0
  end

  def es_uno
    @value == 1
  end

  def value
    @value
  end

  def == un_objeto
    (un_objeto.kind_of? self.class) && (@value==un_objeto.value)
  end

  def hash
    @value.hash
  end

  def sumar_con_fraccion(sumando_fraccion)
    sumando_fraccion.sumar_con_entero self
  end

  def sumar_con_entero(sumando_entero)
    Entero.new @value+sumando_entero.value
  end

  def +(un_sumando)
    un_sumando.sumar_con_entero self
  end

  def multiplicar_con_fraccion(un_multiplicador)
  	un_multiplicador.multiplicar_con_entero self
  end

  def multiplicar_con_entero(un_multiplicador)
  	Entero.new @value*un_multiplicador.value
  end

  def *(un_multiplicador)
    un_multiplicador.multiplicar_con_entero self
  end

  def dividir_con_fraccion(un_dividendo)
  	Fraccion.dividir un_dividendo.numerador, self*un_dividendo.denominador
  end

  def dividir_con_entero(un_dividendo)
      Fraccion.dividir un_dividendo, self
  end

  def /(un_divisor)
    un_divisor.dividir_con_entero self #paso el entero (el dividendo)
  end

  def maximo_comun_divisor_con(otro_entero)
    if otro_entero.es_cero
      self
    else
      otro_entero.maximo_comun_divisor_con self.resto_con otro_entero
    end
  end

  def resto_con(un_divisor)
    Entero.new @value%un_divisor.value
  end

  def divison_entera(un_divisor)
    Entero.new @value/un_divisor.value
  end
end

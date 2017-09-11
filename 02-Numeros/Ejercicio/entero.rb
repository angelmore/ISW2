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
    sumar_fraccion_con_entero(sumando_fraccion, self)
  end

  def sumar_con_entero(sumando_entero)
    Entero.new @value+sumando_entero.value
  end

  def +(un_sumando)
    un_sumando.sumar_con_entero self
  end

  def *(un_multiplicador)
    if un_multiplicador.class == Entero
      Entero.new @value*un_multiplicador.value
    elsif un_multiplicador.class == Fraccion
      Fraccion.dividir (un_multiplicador.numerador * self), un_multiplicador.denominador
    end
  end

  def /(un_divisor)
    if un_divisor.class == Entero
      unDividendo = self
      Fraccion.dividir unDividendo,un_divisor
    elsif un_divisor.class == Fraccion
      Fraccion.dividir (self * un_divisor.denominador), un_divisor.numerador
    end
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

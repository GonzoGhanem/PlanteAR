class Provider < ActiveRecord::Base
  attr_accessible :address, :city, :comments, :name, :phone, :state

  has_many :purchases, dependent: :destroy
  has_many :products
  
  validates_presence_of :name, :message => "Por favor ingrese un nombre para el Proveedor"
  validates_numericality_of :phone, :only_integer => true, :message => "El telefono debe contener solo numeros"
end

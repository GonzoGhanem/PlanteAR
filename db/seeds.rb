# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

LineItem.delete_all
Sell.delete_all
Purchase.delete_all
Product.delete_all
PaymentType.delete_all
Provider.delete_all


payment_type_list = [
  [ "Efectivo"],
  [ "Debito"],
  [ "Credito"]
]

payment_type_list.each do |country|
  PaymentType.create( :name => country[0])
end

products_list = [
	["Rosa Roja", "Es una de las flores mas lindas del mundo y es roja. Color que no me gusta pero zafa.", "rosa_roja.jpg","100","7"],
	["Cactus","Crece en el desierto y sin agua, como mierda no va a crecer en tu casa. Tiene agua adentro.","cactus.jpg","50","6"],
	["Bonsai", "Son arboles miniatura de un arbol cualquiera. Para hacerlos basicamente se los mantiene en macetas pequenias lo que le genera trastornos de crecimiento y desarrollo a la planta y crece deforme (chiquita).","360x270.jpg","20","11"]
]

products_list.each do |product|
	Product.create(:name=>product[0], :description=>product[1], :image_url=>product[2], :stock=>product[3], :list_price=>product[4])
end

providers_list = [
	["Castelli 123", "Venado Tuerto", "El que atiende tiene un loro en el hombro.", "El jardin de pippo","03462443213", "Santa Fe"],
	["Corrientes y San Luis", "Rosario", "El duenio no es de fiar.", "Lo del Rasco","03414453536", "Santa Fe"]
]

providers_list.each do |provider|
	Provider.create(:address=>provider[0], :city=>provider[1], :comments=>provider[2], :name=>provider[3], :phone=>provider[4], :state=>provider[5])
end
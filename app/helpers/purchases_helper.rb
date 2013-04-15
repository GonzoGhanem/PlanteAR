module PurchasesHelper
	def link_to_add_fields (name, f, association)
		new_object = f.object.send(association).klass.new()
		id = new_object.id
		fields = f.fields_for(association, new_object, :child_index=>id) do |builder|
			render(association.to_s.singularize + '_fields', :f=>builder)
		end
		
	end
end

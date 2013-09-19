class SellsDatatable
  delegate :params, :h, :truncate, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Sell.count,
      iTotalDisplayRecords: sells.total_entries,
      aaData: data.push(["Total",@total_amount,"",""])
    }
  end

private

  def data
    sells.map do |sell|
      [
      	PaymentType.find(sell.payment_type_id).name,
      	sell.amount,
      	sell.created_at.strftime("%d/%m/%Y - %H:%M"),
        # sell.date.strftime("%d/%m/%Y"),
      	link_to('Ver', sell)
      ]
    end
  end

  def sells
    @sells ||= fetch_sells
  end

  def fetch_sells
    sells = Sell.order("#{sort_column} #{sort_direction}")
    @total_amount = 0
    if params[:month].present?
      puts "holis"
      sells = sells.where("created_at like :search", search: "%#{params[:month]}%#{params[:year]}%")  
    elsif params[:sSearch].present?
      sells = sells.where("amount like :search or created_at like :search", search: "%#{params[:sSearch]}%")
    end
    sells.each do |sell|
      @total_amount = @total_amount + sell.amount 
    end  
    sells = sells.page(page).per_page(per_page)

    sells
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at]
    columns[params[:iSortCol_2].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
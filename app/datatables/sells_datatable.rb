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
      aaData: data
    }
  end

private

  def data
    sells.map do |sell|
      [
      	PaymentType.find(sell.payment_type_id).name,
      	sell.amount,
      	sell.date.strftime("%d/%m/%Y"),
      	link_to('Ver', sell)
      ]
    end
  end

  def sells
    @sells ||= fetch_sells
  end

  def fetch_sells
    sells = Sell.order("#{sort_column} #{sort_direction}")
    sells = sells.page(page).per_page(per_page)
    if params[:sSearch].present?
      sells = sells.where("amount like :search or date like :search", search: "%#{params[:sSearch]}%")
    end
    sells
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[date]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
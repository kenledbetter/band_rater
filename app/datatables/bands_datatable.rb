class BandsDatatable
  delegate :params, :h, :link_to, :number_with_precision, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Band.count,
      iTotalDisplayRecords: bands.total_entries,
      aaData: data
    }
  end

  private

  def data
    i = 0
    bands.map do |band|
      [
        link_to(band.name, band),
        h(band.location),
        h(band.description),
        number_with_precision(band.average_rating, :precision => 2),
        number_with_precision(band.popularity, :precision => 2)
      ]
    end
  end

  def bands
    @bands ||= fetch_bands
  end

  def fetch_bands
    bands = Band.order("#{sort_column} #{sort_direction}")
    bands = bands.page(page).per_page(per_page)
    if params[:sSearch].present?
      bands = bands.where("name ilike :search or location ilike :search or description ilike :search", search: "%#{params[:sSearch]}%")
    end
    bands
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name location description average_rating popularity]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end

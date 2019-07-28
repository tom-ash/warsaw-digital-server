module AnnouncementsIndex
  EQUAL_PARAMS = %i[ category district rent_currency ]
  MIN_PARAMS = %i[ min_area min_rooms min_rent_amount min_floor min_total_floors ]
  MAX_PARAMS = %i[ max_area max_rooms max_rent_amount max_floor max_total_floors ]
  PER_PAGE = 24
  FULL_ATTRIBUTES = %i[id category district rent_amount rent_currency area pictures rooms floor total_floors availability_date]
  MAP_ATTRIBUTES = %i[id category map_latitude map_longitude]
  FILTERS = [ { name: 'offices', attribute: 'category', value: 0 },
              { name: 'usablePremises', attribute: 'category', value: 1 },
              { name: 'active', attribute: 'active', value: true },
              { name: 'inactive', attribute: 'active', value: false } ]
  SORTERS = { updateasc: 'updated_at', updatedesc: 'updated_at DESC', createasc: 'created_at',
              createdesc: 'created_at DESC', viewsasc: 'views', viewsdesc: 'views DESC' }.with_indifferent_access
  
  def index
    return list if params[:type] == 'list'
    search_announcements
    if request.headers['Only-Amount'] == 'true'
      response = { amount: panel_announcements }
    elsif request.headers['Only-Locations'] == 'true'
      response = { announcements: map_announcements, amount: @amount  }
    else
      response = { announcements: full_announcements, amount: @amount }
    end
    render json: response
  end

  def list
    render_400 and return unless user_validated?
    prepare_announcements
    filter_announcements
    limit_announcements
    sort_announcements
    select_attributes
    render json: { amount: @amount, announcements: @announcements }
  end

  private

  def search_announcements
    @announcements = Announcement.all
    for param in EQUAL_PARAMS
      value = params[param]
      @announcements = @announcements.where(param => value) if value
    end
    for param in MIN_PARAMS
      value = params[param]
      @announcements = @announcements.where("#{param[4..-1]} >= ?", value) if value
    end
    for param in MAX_PARAMS
      value = params[param]
      @announcements = @announcements.where("#{param[4..-1]} <= ?", value) if value
    end
  end

  def panel_announcements
    @amount = @announcements.count
  end

  def map_announcements
    @amount = @announcements.count
    @announcements = @announcements.where.not(map_latitude: nil, map_longitude: nil).limit(50)
    @announcements.select(MAP_ATTRIBUTES)
  end

  def full_announcements
    @amount = @announcements.count
    @announcements.limit(PER_PAGE).offset(offset).select(FULL_ATTRIBUTES)
  end

  def offset
    page = params[:page]
    offset = ['', '1'].include?(page) ? 0 : page.to_i * PER_PAGE - PER_PAGE
  end

  def prepare_announcements
    @amount = @user.announcements.count
    @announcements = @user.announcements
  end

  def filter_announcements
    for filter in FILTERS
      next if request.headers[filter[:name]] == "true"
      @announcements = @announcements.where.not( filter[:attribute] => filter[:value])
    end
  end

  def limit_announcements
    @announcements = @announcements.limit(PER_PAGE).offset!(offset)
  end

  def sort_announcements
    @announcements = @announcements.order(SORTERS[request.headers[:sort]])
  end

  def select_attributes
    @announcements = @announcements.select(FULL_ATTRIBUTES.push(:views, :active, :created_at, :updated_at))
  end
end
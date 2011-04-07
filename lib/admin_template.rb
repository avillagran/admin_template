module AdminTemplateHelpers
  @@default_name        = "Artículos"
  @@default_controller  = "articles"
  @@default_sidebar     = "admin_template/sidebar"

  def at_index(config = {})
=begin
	Default values:
		name : string
		masculino : boolean
		controller : string
		fields : array, [[key, name]]
=end
    set_defaults config

    render :partial => 'admin_template/index', :locals => {:config => config}
  end

  def at_new(config = {})
=begin
	Default values:
		name : string
		masculino : boolean
		controller : string
=end
    set_defaults config

    render :partial => 'admin_template/new', :locals => {:config => config}
  end

  def at_show(config = {})
=begin
	Default values:
		name : string
		masculino : boolean
		controller : string
		fields : array, [[key, name]]
=end
    set_defaults config

    render :partial => 'admin_template/show', :locals => { :config => config }
  end

  def at_edit(config = {})
=begin
	Default values:
		name : string
		masculino : boolean
		controller : string
		fields : array, [[key, name]]
=end
    set_defaults config

    render :partial => 'admin_template/edit', :locals => { :config => config }
  end

  def at_text(config = {})
=begin
	Default values:
		name : string
		content : string
=end
    set_defaults config

    render :partial => 'admin_template/text', :locals => { :config => config }
  end

  def draw_table(config={})

    config[:fields]       = []                unless config.has_key?(:fields)
    config[:values]       = []                unless config.has_key?(:values)
    config[:unique_id]    = (rand*30).round   unless config.has_key?(:unique_id)

    unless config.has_key?(:controller)
      config[:show_links]   = false
    else
      config[:show_links]   = true
    end
    str = ""
    str += '
    <table class="table">
      <tr>
'
    config[:fields].each do |f|
      str += "\t<th" + ( config[:fields].first == f ? ' class="first"' : '')
      str += ( !config[:show_links] && config[:fields].last == f ? ' class="last"' : '') +">"
      str += f[1]
      str += "</th>\n"
    end

    str += "\t"+'<th class="last">&nbsp;</th>' if config[:show_links] or config.has_key?(:actions)
    str += "      </tr>\n     "
    config[:values].each do |i|
      str += "\n     "+'<tr class="' + cycle("odd", "even") + '">
'
      config[:fields].each do |f|
        str += "\t" + '<td>'
        str += i[f[0]].to_s
        str += '</td>' + "\n"
      end
      if(config[:show_links] or config.has_key?(:actions))

        str += '<td class="last">'

        if config.has_key?(:actions)
          config[:actions].each do |a|
            str += '<a href="#" data-uniq="'+config[:unique_id].to_s+'" data-type="'+i.class.to_s+'" data-id="' + i.id.to_s + '"' +(a.has_key?(:class) && !a[:class].blank? ? a[:class] : '')+  '>' + a[:label] + '</a> '
          end
        else
          str += '<a href="' + url_for(:controller => config[:controller], :action => "show", :id => i) + '">Mostrar</a> | '
          str += '<a href="' + url_for(:controller => config[:controller], :action => "edit", :id => i) + '">Editar</a> | '
          str += '<a href="' + url_for(:controller => config[:controller], :action => "destroy", :id => i) + '" data-confirm="¿Estás seguro?" data-method="delete" rel="nofollow">Eliminar</a>'
        end
        str += '</td>'
      end
      str += '</tr>'
    end
    str += '</table>'

    return str
  end

  private
  def set_defaults(config = {})
    config[:masculino] = true 				                        unless config.has_key?(:masculino)
    config[:name] = @@default_name		                        unless config.has_key?(:name)
    config[:controller] = @@default_controller                unless config.has_key?(:controller)
    config[:sidebar] = @@default_sidebar                      unless config.has_key?(:sidebar)
    config[:show_created_at] = false	                        unless config.has_key?(:show_created_at)
    config[:created_at_array] = [['created_at', 'Creado']]    unless config.has_key?(:created_at_array)
    config[:show_id] = false					                        unless config.has_key?(:show_id)

    created_at_array = config[:created_at_array]

    if config.has_key?(:fields)
    	tmp 						 = []
    	tmp						  += [['id', 'ID']] if config[:show_id]
    	tmp						  += config[:fields]
    	tmp 						+= created_at_array if config[:show_created_at]
    	config[:fields]  = tmp
    else
    	config[:fields] = [['id', 'ID']] + created_at_array
    end

    return config
  end
end
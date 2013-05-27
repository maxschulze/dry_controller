module DryController
  extend ActiveSupport::Concern

  included do
    # Preload
    before_filter :resource, :except => [:index]
    before_filter :collection, :only => [:index]

    # Expose to Views
    helper_method :resource, :collection

    rescue_from 'DryController::Errors::ResourceNotFound' do |exception|
      flash[:error] = exception.message
      redirect_to action: :index
    end
  end

  module ClassMethods

    def default_actions(*args)
      args.each do |meth|
        define_method meth.to_sym, lambda {  }
      end
    end

  end

  def resource_name
    controller_name.singularize.downcase
  end

  def collection_name
    controller_name.downcase
  end

  def resource_class
    resource_name.classify.constantize
  rescue NameError => e
    return false
  end

  def resource
    return unless resource_class

    unless obj = instance_variable_get("@#{resource_name}")
      obj ||= if params[:id].present?
        resource_class.where(id: params[:id]).first
      else
        resource_class.new(params[resource_name])
      end

      if obj.blank?
        raise DryController::Errors::ResourceNotFound,
          "#{resource_class.model_name.human}##{params[:id]} could not be found."
      end

      instance_variable_set("@#{resource_name}", obj)
    end

    return obj
  end

  def collection
    return unless resource_class

    unless objects = instance_variable_get("@#{collection_name}")
      objects = resource_class.all
      instance_variable_set("@#{collection_name}", objects)
    end

    return objects
  end

  def resource_missing

  end

end

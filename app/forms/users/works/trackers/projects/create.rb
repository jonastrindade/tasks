class Users::Works::Trackers::Projects::Create
  include ActiveModel::Model

  attr_accessor :status, :type, :message

  def initialize(params)
    @project_params = params.require(:project).permit(:active, :name, :trade_name, :cnpj, :opened_at, :subkind, :notes)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :feature)

    
    @project.attributes = @project_params

    @valid = @project.valid?
  end

  def project
    ::Users::Companies::EntityRepository.build(@kind_params[:kind])
  end

  def save
    # return false unless @can_current_user_create_project
    ActiveRecord::Base.transaction do
      if @valid 
        @project.save 
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        true
      else
        @data = false
        @status = false
        @process = false
        @type = false
        @message = false
        false
      end
    end
  end
  
  def data
    # return cln = [] unless @can_current_user_create_project
    if @data
      cln = ::Users::Companies::EntityRepository.read(@project)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_project
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_project
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_project
    if @message
      message = "Projeto criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @project.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_project?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", @current_user_params[:feature]).can_current_user?
  end

end
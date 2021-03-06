class Clickwrap::Eg001CreateClickwrapController < EgController
  before_action :check_auth

  def create
    results = Clickwrap::Eg001CreateClickwrapService.new(session, request).call

    session[:clickwrap_id] = results.clickwrap_id
    session[:clickwrap_name] = results.clickwrap_name

    @title = 'Creating a new clickwrap'
    @h1 = 'Creating a new clickwrap'
    @message = "The clickwrap #{results.clickwrap_name} has been created!"
    @json = results.to_json.to_json
    render 'ds_common/example_done'
  end

  private

  def check_auth
    minimum_buffer_min = 10
    token_ok = check_token(minimum_buffer_min)
    unless token_ok
      flash[:messages] = 'Sorry, you need to re-authenticate.'
      redirect_to '/ds/mustAuthenticate'
    end
  end
end

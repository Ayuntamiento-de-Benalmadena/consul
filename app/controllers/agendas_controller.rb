class AgendasController < ApplicationController
  include FeatureFlags
  skip_authorization_check

  def show
    @sdg_header = WebSection.find_by!(name: "sdg").header
    @sdg_goals = SDG::Goal.order(:code)
    @phases = []
    @aue_header = WebSection.find_by!(name: "aue").header
    @aue_goals = AUE::Goal.order(:code)
  end
end

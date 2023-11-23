class Admin::SearchesController < ApplicationController
  def search
    @content = params[:content]
    @records = User.search_for(@content).page(params[:page]).per(10)
  end
end

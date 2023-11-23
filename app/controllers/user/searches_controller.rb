class User::SearchesController < ApplicationController
  def search
    @content = params[:content]
    @records = User.search_for(@content)
  end
end

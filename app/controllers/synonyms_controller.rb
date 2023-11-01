class SynonymsController < ApplicationController
    before_action :authorized_synonyms, only: [:index]

    def index
        if params[:word].present? || params[:synonym].present?
            @synonyms = @synonyms.where('word LIKE ? OR synonym LIKE ?', params[:word] && "%#{params[:word]}%", params[:synonym] && "%#{params[:synonym]}%")
        end
        render json: @synonyms
    end

    def create
        synonym = Synonym.new(synonym_params)
        if synonym.save
          render json: synonym, status: :created
        else
          render json: { errors: synonym.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def synonym_params
        params.require(:synonym).permit(:word, :synonym)
    end

    def authorized_synonyms
        @synonyms = Synonym.where(approved: true)
    end
end

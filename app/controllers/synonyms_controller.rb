class SynonymsController < ApplicationController
    before_action :authorized_synonyms, only: [:index]
    before_action :authenticate_admin!, only: [:accept_synonym, :unapproved_synonyms]

    def unapproved_synonyms
        synonyms = Synonym.where(approved: false)
        render json: synonyms
    end

    def accept_synonym
        synonym = Synonym.find_by(id: params[:id])
    
        if synonym
          if synonym.update(approved: true)
            render json: { message: "Synonym #{params[:id]} has been approved." }
          else
            render json: { error: "Failed to approve synonym #{params[:id]}" }, status: :unprocessable_entity
          end
        else
          render json: { error: "Synonym with ID #{params[:id]} not found" }, status: :not_found
        end
    end

    def delete_synonym
      synonym = Synonym.find_by(id: params[:id])
  
      if synonym
        if synonym.destroy
          render json: { message: "Synonym #{params[:id]} has been removed." }
        else
          render json: { error: "Failed to remove synonym #{params[:id]}" }, status: :unprocessable_entity
        end
      else
        render json: { error: "Synonym with ID #{params[:id]} not found" }, status: :not_found
      end
    end

    def index
        if params[:synonym].present?
            @synonyms = @synonyms.where('synonym LIKE ?', params[:synonym] && "%#{params[:synonym]}%")
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

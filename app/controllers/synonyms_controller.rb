class SynonymsController < ApplicationController
  before_action :authorized_synonyms, only: [:index]
  before_action :authenticate_admin!, only: [:accept_synonym, :unapproved_synonyms]

  def index
    @synonyms = search_synonyms
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

  def accept_synonym
    synonym = find_synonym(params[:id])
    return synonym_not_found unless synonym

    if update_synonym_approval(synonym, true)
      render json: { message: "Synonym #{synonym.id} has been approved." }
    else
      render json: { error: "Failed to approve synonym #{synonym.id}" }, status: :unprocessable_entity
    end
  end

  def delete_synonym
    synonym = find_synonym(params[:id])
    return synonym_not_found unless synonym

    if synonym.destroy
      render json: { message: "Synonym #{synonym.id} has been removed." }
    else
      render json: { error: "Failed to remove synonym #{synonym.id}" }, status: :unprocessable_entity
    end
  end

  def unapproved_synonyms
    synonyms = Synonym.where(approved: false)
    render json: synonyms
  end

  private

  def synonym_params
    params.require(:synonym).permit(:word, :synonym)
  end

  def authorized_synonyms
    @synonyms = Synonym.where(approved: true)
  end

  def search_synonyms
    if params[:synonym].present?
      @synonyms = @synonyms.where('synonym LIKE ?', "%#{params[:synonym]}%")
    else
      @synonyms
    end
  end

  def find_synonym(id)
    Synonym.find_by(id: id)
  end

  def update_synonym_approval(synonym, approval_status)
    synonym.update(approved: approval_status)
  end

  def synonym_not_found
    render json: { error: "Synonym with ID #{params[:id]} not found" }, status: :not_found
  end
end

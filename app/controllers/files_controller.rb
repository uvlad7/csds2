class FilesController < ApplicationController
  include EncryptionHelper
  before_action :authenticate_user!

  def show
    render json: current_user.files.find(params[:id])
  end

  def update
    file = current_user.files.find(params[:id])
    file.update(name: params[:new_filename].present? ? params[:new_filename] : params[:filename], text: decrypt(Base64.decode64(current_user.session_key), params[:text]))
    render json: file
  end

  def destroy
    current_user.files.find(params[:id]).destroy
    render json: {
      status: { code: 204, message: 'Deleted successfully.' },
    }
  end

  def create
    render json: NotepadFile.create(user_id: current_user.id, name: params[:filename], text: decrypt(Base64.decode64(current_user.session_key), params[:text]))
  end

  def index
    render json: current_user.notepad_files.pluck(:name)
  end
end

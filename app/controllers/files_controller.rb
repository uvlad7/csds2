class FilesController < ApplicationController
  before_action :authenticate_user!

  def show
    NotepadFile.where("user_id = #{current_user.id} and name = #{params[:filename]}")
  end

  def update
    file = NotepadFile.where("user_id = #{current_user.id} and name = #{params[:filename]}")
    file.update(name: params[:new_filename].present? ? params[:new_filename] : params[:filename], text: decrypt(user.session_key, params[:text]))
    file
  end

  def delete
    file = NotepadFile.where("user_id = #{current_user.id} and name = #{params[:filename]}").destroy
  end

  def create
    NotepadFile.create(name: params[:filename], text: decrypt(user.session_key, params[:text]))
  end

  def index
    current_user.notepad_files.map { |f| f.name }
  end
end

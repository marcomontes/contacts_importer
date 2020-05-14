class CsvFilesController < ApplicationController

  def index
    @csv_files = CsvFile.all
  end

  def new
    @csv_file = CsvFile.new
  end

  def create
    @csv_file = current_user.csv_files.new(csv_file_params)

    if @csv_file.save
      redirect_to csv_files_url, notice: 'CSV File was successfully imported.'
    else
      render :new
    end
  end

  private
    def csv_file_params
      params.require(:csv_file).permit(:contacts_file, columns: {})
    end
end

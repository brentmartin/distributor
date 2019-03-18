class UploadsController < ApplicationController

  def index
  end

  def upload
    # Save the file... somewhere
    # Write the file to IPFS node
    uploaded_io = params[:picture]
    uploaded_file_name = uploaded_io.original_filename
    File.open(Rails.root.join('public', 'uploads', uploaded_file_name), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    ssh_output = %x[scp -i ~/.ssh/id_rsa #{Rails.root.join('public', 'uploads', uploaded_file_name)} opc@132.145.175.73:~/]
    p ssh_output
    ipfs_output = %x[ssh -t opc@132.145.175.73 \"IPFS_PATH=/data/ipfs ipfs add /home/opc/#{uploaded_file_name}\"]
    p ipfs_output
    @ipfs_uuid = ipfs_output.split(" ")[ipfs_output.split(" ").index("added") + 1]

    render :index
  end
end

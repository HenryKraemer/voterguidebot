require 'digest'
require 'aws-sdk'

class S3Wrapper
  DownloadFailed = Class.new StandardError

  def initialize(bucket = nil)
    bucket(bucket)
  end

  def upload_file(path_to_file, key=nil)
    puts "Uploaded #{path_to_file}"
    object(key || path_to_file).upload_file(path_to_file)
  end

  def download_file(path_to_file, key=nil)
    key ||= path_to_file
    File.open(path_to_file, 'wb') {  |file| file.write(object(key).get.body.read) }
    rescue Aws::S3::Errors::AccessDenied
    raise DownloadFailed, "Could not download #{key}"
  end

  def upload_directory(path_to_directory)
    Dir.chdir path_to_directory
    Dir['**/*.*'].each do |file|
      upload_file_if_changed(file)
    end
  end

  def upload_file_if_changed(path_to_file, key=nil)
    object = object(key || path_to_file)

    return if will_multipart?(path_to_file) && object.exists?

    begin
      return if object.etag.gsub(/[^a-zA-Z\d]/, '') == md5(path_to_file)
      puts "File changed - uploading #{path_to_file}"
    rescue Aws::S3::Errors::NotFound,
           Aws::S3::Errors::Forbidden
      puts "File not found - uploading #{path_to_file}"
    end

    object.upload_file(path_to_file)
  end

  def object(object_key)
    bucket.object(object_key)
  end

  def md5(path_to_file)
    md5 = Digest::MD5.new
    md5.update(File.read(path_to_file))
    md5.hexdigest
  end

  def will_multipart?(path_to_file)
    File.size(path_to_file) > 1024 * 1024 * 20
  end

  private

  def s3
    self.class.s3
  end

  def bucket(bucket = nil)
    @bucket ||= s3.bucket(bucket || ENV.fetch('S3_BUCKET_NAME'))
  end

  def self.s3
    @s3 ||= Aws::S3::Resource.new region: ENV.fetch('AWS_REGION')
  end
end


require 'em-midori/extension/file'
CONTENT_TYPE = {
    'css': 'text/css',
    'gif': 'image/gif',
    'html': 'text/html',
    'ico': 'image/x-icon',
    'jpeg': 'image/jpeg',
    'jpg': 'image/jpeg',
    'js': 'text/javascript',
    'json': 'application/json',
    'pdf': 'application/pdf',
    'png': 'image/png',
    'svg': 'image/svg+xml',
    'swf': 'application/x-shockwave-flash',
    'tiff': 'image/tiff',
    'txt': 'text/plain',
    'wav': 'audio/x-wav',
    'wma': 'audio/x-ms-wma',
    'wmv': 'video/x-ms-wmv',
    'xml': 'text/xml'
}

class StaticRoute < Midori::API
  capture Errno::ENOENT do
    Midori::Response.new(404, {}, 'File not Found')
  end

  get '*' do
    file_path = @request.params['splat'][0].gsub(/\.\.\//, '').gsub(/\.\//, '')
    content_type = CONTENT_TYPE[file_path.split('.')[-1]] || 'text/plain'
    Midori::Response.new(200,
                         {'Content-Type': content_type},
                         Midori::File.read('./static' + file_path))
  end
end
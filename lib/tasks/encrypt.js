crypto = require('crypto')
const algorithm = 'aes-256-cfb';
module.exports = function (opts, done) {
  const [keyStr, content] = opts.split(' ')
  const iv = crypto.randomBytes(16)
  var cipher = crypto.createCipheriv(algorithm, keyStr, iv)
  cipher.setAutoPadding(0)
  var crypted = cipher.update(text, 'utf-8', "base64")
  crypted = cipher.final("base64")
  done(null, { result: iv.toString('hex') + ':' + crypted });
}

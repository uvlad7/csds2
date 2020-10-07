crypto = require('crypto')
const algorithm = 'aes-256-cfb';
module.exports = function (opts, done) {
  const [keyStr, ...text] = opts.split(' ')
  const textJoined = text.join(' ')
  const iv = crypto.randomBytes(16)
  var cipher = crypto.createCipheriv(algorithm, keyStr, iv)
  var crypted = cipher.update(textJoined, 'utf-8', "base64")
  crypted += cipher.final("base64")
  done(null, { result: iv.toString('hex') + ':' + crypted });
}

crypto = require('crypto')
const algorithm = 'aes-256-cfb';
module.exports = function (opts, done) {
  const [keyStr, content] = opts.split(' ')
  const [ivString, text] = content.split(':')
  var iv = Buffer.from(ivString, 'hex')
  var decipher = crypto.createDecipheriv(algorithm, keyStr, iv);
  var result = decipher.update(text, 'base64', 'utf-8');
  result += decipher.final();
  done(null, {result});
}

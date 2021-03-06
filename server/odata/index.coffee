odata = require('node-odata')
requires = require('./../utils/requires')

module.exports =
  setup : (app, conn) ->
    odata.set('app', app)
    odata.set('db', conn)

    dirs = ['article', 'board', 'gallery', 'system']
    for dir in dirs
      for item in requires("#{__dirname}/#{dir}") when item.url
        odata.resources.register item

    require('./functions')()

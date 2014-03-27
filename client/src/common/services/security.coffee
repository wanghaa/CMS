﻿angular.module("zy.services.security", ['resource.users', 'zy.services.context'])
.factory "security", ['User','context','$q', "$http", (User, context, $q, $http) ->
  autoLogin: ->
    self = this
    deferred = $q.defer()
    token=$.cookie('authorization')
    if token
      $http.defaults.headers.common['authorization']=token
      User.autoSignin {id:'(1)'}, null
      ,(data)->
        deferred.resolve data
      ,(error)->
        deferred.reject undefined
    else
      deferred.reject undefined
    deferred.promise

  login: (user) ->
    self = this
    deferred = $q.defer()
    User.signin {id:'(1)'}, user
    ,(data, headers)->
      if user.IsRemember
        $.cookie('authorization', headers('authorization'), {expires: 180, path: '/'})
      else
        $.cookie('authorization', headers('authorization'), { path: '/'})
      deferred.resolve data
    ,(error)->
      deferred.reject undefined
    deferred.promise
  logoff: ->
    self = this
    deferred = $q.defer()
    User.signout {id:'(1)'}
    ,(data)->
      $.removeCookie('authorization')
      delete $http.defaults.headers.common['authorization']
      deferred.resolve "OK"
    deferred.promise
]
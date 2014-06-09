﻿angular.module("resource.photos", ["ngResource"])
.factory "Photo", ['$resource',($resource) ->
  $resource "#{config.apiHost}/Photo:id/:action", {id:'@id',action:'@action'},
    query:
      method: "GET"
      params:
        $orderby:'CreateDate desc'
    update:
      method: "PUT"
]
root = global ? window

<%= @plural_model_name %>_mod = angular.module("<%= @plural_model_name %>", ["ngResource", "ui.router"])


<%= @plural_model_name %>_mod.factory "<%= @model_name %>", ['$resource', "$location", "flash",  ($resource, $location, flash) ->
  <%= "#{@model_name}" %> = $resource("/<%= @plural_model_name %>/:action/:id",
    id: "@id",
    format: "json"
  ,
    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )
  <%= "#{@model_name}" %>::destroy = (success, failure) ->
    <%= "#{@model_name}" %>.remove
      id: @id
    , success
    , (error) ->
      failure(error.status) 
  
        
  <%= "#{@model_name}" %>
]

root.angular = angular

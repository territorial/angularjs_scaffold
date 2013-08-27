root = global ? window

<%= @plural_model_name %>_mod = angular.module("<%= @plural_model_name %>", ["ngResource", 'ui.router', 'ui.compat'])

<%= @plural_model_name %>_mod.config(['$stateProvider', ($stateProvider) ->

  $stateProvider.state("list_<%= @plural_model_name %>",
    url: "/<%= @plural_model_name %>", 
    controller: <%= @model_name.pluralize %>IndexCtrl,
    templateUrl: '<%%= asset_path("<%= @plural_model_name %>/index.html") %>'
  ).state("new_<%= @model_name.downcase %>",
    url: "/<%= @plural_model_name %>/new",
    controller: <%= @model_name.pluralize %>CreateCtrl,
    templateUrl: '<%%= asset_path("<%= @plural_model_name %>/new.html") %>'
  ).state("show_<%= @model_name.downcase %>",
    url: "/<%= @plural_model_name %>/:id",
    controller: <%= @model_name.pluralize %>ShowCtrl,
    templateUrl: '<%%= asset_path("<%= @plural_model_name %>/show.html") %>'
  ).state("edit_<%= @model_name.downcase %>",
    url: "/<%= @plural_model_name %>/:id/edit",
    controller: <%= @model_name.pluralize %>EditCtrl,
    templateUrl: '<%%= asset_path("<%= @plural_model_name %>/edit.html") %>'
  )
    
  
])

<%= @plural_model_name %>_mod.factory "<%= @model_name %>", ['$resource', ($resource) ->
  <%= "#{@model_name}" %> = $resource("/<%= @plural_model_name %>/:action/:id",
    id: "@id",
    format: "json"
  ,
    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )
  <%= "#{@model_name}" %>::destroy = (cb) ->
    <%= "#{@model_name}" %>.remove
      id: @id
    , cb

  <%= "#{@model_name}" %>
]

root.angular = angular

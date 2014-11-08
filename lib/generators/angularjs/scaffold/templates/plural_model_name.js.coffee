root = global ? window

<%= @plural_model_name %>_mod = angular.module("<%= @plural_model_name %>", ["ngResource", "ui.router"])

<%= @plural_model_name %>_mod.config(['$stateProvider', ($stateProvider) ->

  console.log("module <%= @plural_model_name %> initialized");
  
  basepath = (uri) ->
    "/assets/templates/<%= @plural_model_name %>/" + uri
    
  $stateProvider.state("list_<%= @plural_model_name %>",
    url: "/<%= @plural_model_name %>", 
    controller: <%= @model_name.pluralize %>IndexCtrl,
    templateUrl: basepath('index.html')
  ).state("new_<%= @model_name.downcase %>",
    url: "/<%= @plural_model_name %>/new",
    controller: <%= @model_name.pluralize %>CreateCtrl,
    templateUrl: basepath('new.html')
  ).state("show_<%= @model_name.downcase %>",
    url: "/<%= @plural_model_name %>/:id",
    controller: <%= @model_name.pluralize %>ShowCtrl,
    templateUrl: basepath('show.html')
  ).state("edit_<%= @model_name.downcase %>",
    url: "/<%= @plural_model_name %>/:id/edit",
    controller: <%= @model_name.pluralize %>EditCtrl,
    templateUrl: basepath('edit.html')
  )
    
  
])

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
  <%= "#{@model_name}" %>::destroy = (cb) ->
    <%= "#{@model_name}" %>.remove
      id: @id
    , cb
    , (error) ->
        bootbox.alert {title: "Error", message: "Failed to perform this operation. #{error.status}"} 
  
  <%= @model_name  %>::confirm_destroy = ($scope) ->
    console.log "confirm_destroy called"
    
    $scope.curr_<%= @model_name.downcase  %> = this
    bootbox.confirm "Are you sure ?", (confirmed) ->

      if confirmed
        $scope.$apply ->
          $scope.curr_<%= @model_name.downcase  %>.destroy ->
            console.log "Destroyed " + $scope.curr_<%= @model_name.downcase  %>.id + " in confirmed callback"
            $scope.<%= @plural_model_name %> = _.without($scope.<%= @plural_model_name %>, $scope.curr_<%= @model_name.downcase  %>)
            flash.success = "Deleted <%= @model_name.downcase  %> successfully"
            $location.path("/<%= @plural_model_name %>")

      else
        console.log "Cancelled"
        
  <%= "#{@model_name}" %>
]

root.angular = angular


root = global ? window

<%= @controller %>IndexCtrl = ($scope, <%= @model_name %>, flash) ->
  $scope.<%= @plural_model_name %> = <%= @model_name %>.query()
  $scope.<%= @plural_model_name %>.$promise.then ((data) ->
      # success handler
    ), (error) ->
      bootbox.alert {title: "Error", message: "Failed to perform this operation. #{error.status}"}
      # error handler

  $scope.destroy = ->
    @<%= @resource_name %>.confirm_destroy($scope)
        
<%= @controller %>IndexCtrl.$inject = ['$scope', '<%= @model_name %>', 'flash'];

<%= @controller %>CreateCtrl = ($scope, $location, <%= @model_name %>, flash) ->
  $scope.save = ->
    <%= @model_name %>.save $scope.<%= @resource_name %>, (<%= @resource_name %>) ->
      $location.path "/<%= @plural_model_name %>"
      flash.success = "<%= @model_name %> created successfully"
    , (error) ->
      bootbox.alert {title: "Error", message: "Failed to perform this operation. #{error.status}"}
       
<%= @controller %>CreateCtrl.$inject = ['$scope', '$location', '<%= @model_name %>', 'flash'];

<%= @controller %>ShowCtrl = ($scope, $location, $stateParams, <%= @model_name %>, flash) ->
  <%= @model_name %>.get
    id: $stateParams.id
  , (<%= @resource_name %>) ->
    @original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(@original)
  , (error) ->
    bootbox.alert {title: "Error", message: "Failed to perform this operation. #{error.status}"}
      
  $scope.destroy = ->
    @<%= @resource_name %>.confirm_destroy($scope)
        
<%= @controller %>ShowCtrl.$inject = ['$scope', '$location', '$stateParams', '<%= @model_name %>', 'flash'];

<%= @controller %>EditCtrl = ($scope, $location, $stateParams, <%= @model_name %>, flash) ->
  <%= @model_name %>.get
    id: $stateParams.id
  , (<%= @resource_name %>) ->
    @original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(@original)
  , (error) ->
    bootbox.alert {title: "Error", message: "Failed to perform this operation. #{error.status}"}
      
  $scope.isClean = ->
    console.log "[<%= @controller %>EditCtrl, $scope.isClean]"
    angular.equals @original, $scope.<%= @resource_name %>

  $scope.destroy = ->
    @<%= @resource_name %>.confirm_destroy($scope)

  $scope.save = ->
    <%= @model_name %>.update $scope.<%= @resource_name %>, (<%= @resource_name %>) ->
      $location.path "/<%= @plural_model_name %>"
      flash.success = "<%= @model_name %> saved successfully"
    , (error) ->
      bootbox.alert {title: "Error", message: "Failed to perform this operation. #{error.status}"}

<%= @controller %>EditCtrl.$inject = ['$scope', '$location', '$stateParams', '<%= @model_name %>', 'flash'];

# exports
root.<%= @controller %>IndexCtrl  = <%= @controller %>IndexCtrl
root.<%= @controller %>CreateCtrl = <%= @controller %>CreateCtrl
root.<%= @controller %>ShowCtrl   = <%= @controller %>ShowCtrl
root.<%= @controller %>EditCtrl   = <%= @controller %>EditCtrl 
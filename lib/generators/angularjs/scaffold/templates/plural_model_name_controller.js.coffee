
root = global ? window

<%= @controller %>IndexCtrl = ($scope, $location, <%= @model_name %>, flash, modalService) ->
  $scope.<%= @plural_model_name %> = <%= @model_name %>.query()
  $scope.<%= @plural_model_name %>.$promise.then ((data) ->
      # success handler
    ), (error) ->
      modalService.showOperationFailed(error)
      # error handler

  $scope.destroy = ->
    <%= @resource_name %> = @<%= @resource_name %>

    modalService.showConfirmDelete("<%= @resource_name %>", "<%= @resource_name %>").then (result) ->
      <%= @resource_name %>.destroy -> 
        console.log("Destroy <%= @resource_name %> successfully")
        $scope.<%= @plural_model_name %> = _.without($scope.<%= @plural_model_name %>, <%= @resource_name %>)
        $location.path "/<%= @plural_model_name %>"
      , ->
        console.log("Destroy <%= @resource_name %> unsuccessful")

    return
        
<%= @controller %>IndexCtrl.$inject = ['$scope', '$location', '<%= @model_name %>', 'flash', 'modalService'];

<%= @controller %>CreateCtrl = ($scope, $location, <%= @model_name %>, flash, modalService) ->
  $scope.save = ->
    <%= @model_name %>.save $scope.<%= @resource_name %>, (<%= @resource_name %>) ->
      $location.path "/<%= @plural_model_name %>"
      flash.success = "<%= @model_name %> created successfully"
    , (error) ->
      modalService.showOperationFailed(error)
       
<%= @controller %>CreateCtrl.$inject = ['$scope', '$location', '<%= @model_name %>', 'flash', 'modalService'];

<%= @controller %>ShowCtrl = ($scope, $location, $stateParams, <%= @model_name %>, flash, modalService) ->
  <%= @model_name %>.get
    id: $stateParams.id
  , (<%= @resource_name %>) ->
    @original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(@original)
  , (error) ->
    modalService.showOperationFailed(error)
      
  $scope.destroy = ->
    @<%= @resource_name %>.confirm_destroy($scope)
        
<%= @controller %>ShowCtrl.$inject = ['$scope', '$location', '$stateParams', '<%= @model_name %>', 'flash', 'modalService'];

<%= @controller %>EditCtrl = ($scope, $location, $stateParams, <%= @model_name %>, flash, modalService) ->
  <%= @model_name %>.get
    id: $stateParams.id
  , (<%= @resource_name %>) ->
    @original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(@original)
  , (error) ->
    modalService.showOperationFailed(error)
      
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
      modalService.showOperationFailed(error)

<%= @controller %>EditCtrl.$inject = ['$scope', '$location', '$stateParams', '<%= @model_name %>', 'flash', 'modalService'];


<%= @plural_model_name %>_mod = angular.module("<%= @plural_model_name %>")

<%= @plural_model_name %>_mod.controller "<%= @controller %>IndexCtrl", <%= @controller %>IndexCtrl
<%= @plural_model_name %>_mod.controller "<%= @controller %>CreateCtrl", <%= @controller %>CreateCtrl
<%= @plural_model_name %>_mod.controller "<%= @controller %>ShowCtrl", <%= @controller %>ShowCtrl
<%= @plural_model_name %>_mod.controller "<%= @controller %>EditCtrl", <%= @controller %>EditCtrl

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
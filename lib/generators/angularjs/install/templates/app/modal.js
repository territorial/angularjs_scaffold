App.service('modalService', [ '$modal', function($modal) {

	var confirmDefaults = {
		backdrop : true,
		keyboard : true,
		modalFade : true,
		templateUrl : '/assets/templates/views/partials/confirm.html'
	};

	var confirmOptions = {
		closeButtonText : 'Cancel',
		actionButtonText : 'Ok',
		headerText : 'Proceed?',
		bodyText : 'Perform this action?'
	};
	
	var alertDefaults = {
		backdrop : true,
		keyboard : true,
		modalFade : true,
		templateUrl : '/assets/templates/views/partials/alert.html'
	};

	var alertOptions = {
		closeButtonText : 'Close',
		actionButtonText : '',
		headerText : 'Alert',
		bodyText : 'Alert'
	};

	this.showConfirm = function(modalDefaults, modalOptions) {
		if (!modalDefaults)
			modalDefaults = {};
		modalDefaults.backdrop = 'static';
		return this.show(modalDefaults, confirmDefaults, modalOptions, confirmOptions);
	};
	
	this.showAlert = function(modalDefaults, modalOptions) {
		if (!modalDefaults)
			modalDefaults = {};
		modalDefaults.backdrop = 'static';
		return this.show(modalDefaults, alertDefaults, modalOptions, alertOptions);
	};
	
	
	this.showOperationFailed = function(error) {		
		modalDefaults = {};
		modalOptions  = {headerText: "Error", bodyText: "Failed to perform this operation. Error " + error.status};
		modalDefaults.backdrop = 'static';
		return this.show(modalDefaults, alertDefaults, modalOptions, alertOptions);
	};
	
	this.showConfirmDelete = function(entity, entityDetails) {		
		modalDefaults = {};
		modalOptions  = {closeButtonText: "Cancel",
						actionButtonText: "Delete User",
						headerText: "Delete " + entityDetails + "?",
						bodyText: "Are you sure you want to delete " +  entity + "?"};
		modalDefaults.backdrop = 'static';
		return this.show(modalDefaults, confirmDefaults, modalOptions, confirmOptions);
	};

	this.show = function(customModalDefaults, baseDefaults, customModalOptions, baseOptions) {
		// Create temp objects to work with since we're in a singleton service
		var tempModalDefaults = {};
		var tempModalOptions = {};

		// Map angular-ui modal custom defaults to modal defaults defined in
		// service
		angular.extend(tempModalDefaults, baseDefaults, customModalDefaults);

		// Map modal.html $scope custom properties to defaults defined in
		// service
		angular.extend(tempModalOptions, baseOptions, customModalOptions);

		if (!tempModalDefaults.controller) {
			tempModalDefaults.controller = function($scope, $modalInstance) {
				$scope.modalOptions = tempModalOptions;
				$scope.modalOptions.ok = function(result) {
					$modalInstance.close(result);
				};
				$scope.modalOptions.close = function(result) {
					$modalInstance.dismiss('cancel');
				};
			}
		}

		return $modal.open(tempModalDefaults).result;
	};

} ]);
root = global ? window

# Credits: https://variadic.me/posts/2013-10-15-share-state-between-controllers-in-angularjs.html 
# This service is used to store the session both on the rootScope and locally
# Also broadcasts a Session.Update when the session changes
angular.module("services", []).factory "session", ($rootScope, User) ->
  "use strict"
  
  session = undefined
  
  broadcast = (val) ->
    $rootScope.$broadcast "Session.Update", val
    return

  refresh = ->
    console.log "Refreshing session"
    # Get the current logged in users details
    User.get_current_user ((current_user) ->
      # ensure the session service is setup
      update(current_user)        
    )
    
  update = (newSession) ->
    console.log newSession
    session = newSession
    # Add the session to the rootScope so its avail globally
    $rootScope.current_user = session
    # broadcast change
    broadcast(session)
    return

  # Convinience method to be used for callback
  onUpdate = ($scope, callback) ->
    $scope.$on "Session.Update", (val) ->
      callback(session)
      return

  return {
    update: update
    session: session
    onUpdate: onUpdate
    refresh: refresh
  }

  

root.angular = angular
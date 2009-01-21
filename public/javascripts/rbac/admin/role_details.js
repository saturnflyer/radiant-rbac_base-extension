function RoleManager() {
	var role_id = "";
	var available = null;
	var taken = null;
	var drag_refs = new Object();
}

var spinners = {
	show: function(){
		$('busy_taken', 'busy_available').invoke('show');
	},
	hide: function(){
		$('busy_taken', 'busy_available').invoke('hide');
	}
}

RoleManager.prototype.updateDraggables = function() {
	try {
		if(this.drag_refs == undefined || this.drag_refs == NULL) {
			this.drag_refs = new Object();
		}
		
		this.available.each(function(e) { 
			var my_draggable = new Draggable("user_" + e[0], {constraint: 'vertical', revert: true} ); 
			manager.drag_refs["user_" + e[0]] = my_draggable;
		});
		this.taken.each(function(e) {
			var my_draggable = new Draggable("user_" + e[0], {constraint: 'vertical', revert: true} );
			manager.drag_refs["user_" + e[0]] = my_draggable;
		});
	} catch(e) {
		alert("An exception occured while making the users draggable: " + e.description);
	}
}

RoleManager.prototype.updateData = function(data) {
	data.available.each(function(e) { 
		new Insertion.Bottom('available_users', "<li class='user' id='user_" + e[0] + "' value='" + e[0] + "'>" + e[1] + "</li>"); 
	});
	
	data.taken.each(function(e) {
		new Insertion.Bottom('taken_users', "<li class='user' id='user_" + e[0] + "' value='" + e[0] + "'>" + e[1] + "</li>");
	});
	
	this.available = data.available;
	this.taken = data.taken;
}

RoleManager.prototype.addUser = function(element) {
  user_id = element.readAttribute("value");
	new Ajax.Request("/admin/roles/"+role_id+"/users/"+user_id, {
	  method: 'post',
		onCreate: function(){
			spinners.show();
		},
		onSuccess: function(transport) {
			var response = transport.responseText.evalJSON();
			var _id = "user_" + response.user_id;
			if(response.status == "Ok") {
				var element = $(_id)
				var _value = response.user_id
				var _text = element.innerHTML;
				
				element.toggle();
				manager.drag_refs[_id].destroy();
				element.remove();
				new Insertion.Bottom('taken_users', "<li class='user' id='" + _id + 
					"' value='" + _value + "'>" + _text + "</li>");
				manager.drag_refs[_id] = new Draggable(_id);
			} else {
				alert("There was a problem adding the user to this role.");
				manager.drag_refs[_id].destroy();
				manager.drag_refs[_id] = new Draggable(_id);
			}
			spinners.hide();
		},
		onFailure: function(transport) {
			alert("There was a problem adding the user to this role.");
			spinners.hide();
		}
	});
}

RoleManager.prototype.removeUser = function(element) {
  user_id = element.readAttribute("value");
	new Ajax.Request("/admin/roles/"+role_id+"/users/"+user_id, {
	  method: 'delete',
		onCreate: function() {
			spinners.show();
		},
		onSuccess: function(transport) {
			var response = transport.responseText.evalJSON();
			var _id = "user_" + response.user_id;
			if(response.status == "Ok") {
				var element = $(_id)
				var _value = response.user_id
				var _text = element.innerHTML;
				
				element.toggle();
				manager.drag_refs[_id].destroy();
				element.remove();
				new Insertion.Bottom('available_users', "<li class='user' id='" + _id + 
					"' value='" + _value + "'>" + _text + "</li>");
				manager.drag_refs[_id] = new Draggable(_id);
			} else {
				alert("There was a problem removing the user from this role.");
				manager.drag_refs[_id].destroy();
				manager.drag_refs[_id] = new Draggable(_id);
			}
			spinners.hide();
		},
		onFailure: function(transport) {
			alert("There was a problem removing the user from this role.");
			spinners.hide();
		}
	})
}

RoleManager.prototype.loadData = function(role_id) {
	new Ajax.Request('/admin/roles/'+role_id+'/users', { 
	    method: 'get',
	    contentType: 'application/javascript',
			onCreate: function(){
				spinners.show();
			},
			onFailure: function(transport) {
				alert('There was a problem with the script');
				spinners.hide();
			},
			onSuccess: function(transport) {
			try {
				var val = transport.responseText.evalJSON();
				manager.updateData(val);
				new PeriodicalExecuter(function(pe) { manager.updateDraggables(); pe.stop(); }, 0.1);
				Droppables.add('available_users', { 
					accept: "user",
					hoverclass: "hover",
					onDrop: function(element) {
						manager.removeUser(element);
					} 
				});
				Droppables.add('taken_users', {
					accept: "user",
					hoverclass: "hover",
					onDrop: function(element) {
						manager.addUser(element);
					}
				});
				spinners.hide();
			} catch(e) {
				alert("Exception occured in json code: " + e);
				spinners.hide();
			}
		}
	});
}

var manager = new RoleManager();

Event.observe(window, 'load', function() {
	manager.loadData(role_id);
});
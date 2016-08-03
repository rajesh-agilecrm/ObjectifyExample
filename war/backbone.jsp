<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@ include file="header.jsp" %>
		<div class="container" id="container_dev">
			
		</div>		
		<script id="artist-list-template" type="text/x-handlebars-template">
			<div class="table-responsive" style="width: 100%;margin-top: 60px;">
				<table class="table">
  				<thead>
    				<tr>
      					<th>User Name</th>
      					<th>Full Name</th>
      					<th>Mobile Number</th>
						<th>Gender</th>
						<th>Date Of Birth</th>
    				</tr>
  				</thead>
  				<tbody>
      				{{#each []}}
      				<tr>
          				<td>{{this.email}}</td>
          				<td>{{this.fullname}}</td>
						<td>{{this.mobilenumber}}</td>
						<td>{{this.gender}}</td>
						<td>{{this.dob}}</td>
      				</tr>
      				{{/each}}
  				</tbody>
			</table>
		</div>
	</script>
	<script type="text/javascript">
	(function () {
		/*var modelItem = Backbone.Model.extend({
			defaults:{
				email:'',
				fullname:'',
				mobilenumber:''
			},
		});*/
		var CarCollection = Backbone.Collection.extend({
			url: '/rest/hello'
			//model: modelItem
		});
		var viewItem = Backbone.View.extend({
			el:'#container_dev',
			initialize:function(){
				_.bindAll(this,'render')
				var self = this;
				this.carCollectionInstance = new CarCollection();
				this.carCollectionInstance.fetch({
					success: function(data,response,xhr) {
						self.render(data);
					},
					error: function (errorResponse) {
						console.log(errorResponse)
					}
				});	
			},
			render:function(data){
				var source = $('#artist-list-template').html();
		        var template = Handlebars.compile(source);
		        var html = template(data.toJSON());
		        this.$el.html(html);
			}
		});
		var viewitem = new viewItem();
	})(jQuery);
	</script>
	</body>
</html>
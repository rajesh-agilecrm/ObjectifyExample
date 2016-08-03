<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%@ include file="header.jsp" %>
	<div class="container">
		<div class="col-md-12" style="margin-top:60px;">
			<span><a href="#" class="btn btn-success" data-toggle="modal" data-target="#myModal">Create Employee</a></span>
		</div>
		<div class="alert alert-success fade in" style="display:none;margin-top:95px;">
		    <a href="#" class="close" data-dismiss="alert">&times;</a>
		    <strong>Success!</strong> Employee has been created.
		</div>
	</div>
	<div class="container" id="container_dev" style="margin-top: -75px;">
	</div>		
	<div class="container">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		        <h4 class="modal-title" id="myModalLabel">Create Employee</h4>
		      </div>
		      <form method="POST" id="createemp">
			      <div class="modal-body">
			        <div class="form-group">
			        	<label>Full Name</label>
			        	<input type="text" name="fullname" class="form-control" placeholder="Enter fullname" required/>
			        </div>
			        <div class="form-group">
			        	<label>Email Address</label>
			        	<input type="email" name="email" class="form-control" placeholder="Enter email address" required/>
			        </div>
			        <div class="form-group">
			        	<label>Enter Password</label>
			        	<input type="password" name="password" class="form-control" placeholder="Enter password" required/>
			        </div>
			        <div class="form-group">
			        	<label>Employee Id</label>
			        	<input type="text" name="empid" class="form-control" placeholder="Enter employee id" required/>
			        </div>
			        <div class="form-group">
			        	<label>Designation </label>
			        	<input type="text" name="designation" class="form-control" placeholder="Enter designation" required/>
			        </div>
			        <input type="hidden" name="keyid" value="<%=request.getSession().getAttribute("id") %>" />
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="submit" id="submit" class="btn btn-primary">Submit</button>
			      </div>
		      </form>
		    </div>
		  </div>
		</div>
	</div>
	<script id="artist-list-template" type="text/x-handlebars-template">
			<div class="table-responsive" style="width: 100%;margin-top: 60px;">
				<table class="table">
  				<thead>
    				<tr>
      					<th>Full Name</th>
						<th>Email</th>
      					<th>Emp ID</th>
						<th>Designation</th>
						<th>Created By</th>
						<th>Created Date</th>
    				</tr>
  				</thead>
  				<tbody id="myTable">
      				{{#each []}}
      				<tr>
          				<td>{{this.fullname}}</td>
          				<td>{{this.email}}</td>
						<td>{{this.empid}}</td>
						<td>{{this.designation}}</td>
						<td>{{this.register.fullname}}</td>
						<td>{{this.created_on}}</td>
      				</tr>
      				{{/each}}
  				</tbody>
			</table>
			<div id="pagination" class="pagination">
      			<ul class="pagination pager" id="myPager"></ul>
      		</div>
		</div>
	</script>
	<script type="text/javascript">
		var viewItem;
		var frm = $('#createemp');
    	frm.submit(function (ev) {
    		var dataform = $(this).serializeFormJSON();
    		$.ajax({
    			beforeSend: function (request)
                {
                    request.setRequestHeader("Content-Type", "application/json");
                },
			  	url: "/rest/emp/create",
			  	method: frm.attr('method'),
			  	data: JSON.stringify(dataform),
			  	dataType: "html",
			 	success: function(data,status){
					if(data == "success"){
						$(".alert-success").show();
						$('#myModal').modal('hide');
						$('#createemp')[0].reset();
						new viewItem();
					}
			  	}
			});
    		ev.preventDefault();
    	});
    	(function ($) {
    	    $.fn.serializeFormJSON = function () {
    	        var o = {};
    	        var a = this.serializeArray();
    	        $.each(a, function () {
    	            o[this.name] = this.value;
    	        });
    	        return o;
    	    };
    	})(jQuery);
    	
    	(function () {
    		var CarCollection = Backbone.Collection.extend({
    			url: '/rest/emp/getEmpDetails'
    		});
    		viewItem = Backbone.View.extend({
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
    		        var template = Handlebars.compile(source)
    		        var html = template(data.toJSON());
    		        this.$el.html(html);
    		        $('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:true,perPage:4});
    			}
    		});
    		var viewitem = new viewItem();
    	})(jQuery);
    	
    	$.fn.pageMe = function(opts){
    	    var $this = this,
    	        defaults = {
    	            perPage: 7,
    	            showPrevNext: false,
    	            hidePageNumbers: false
    	        },
    	        settings = $.extend(defaults, opts);
    	    
    	    var listElement = $this;
    	    var perPage = settings.perPage; 
    	    var children = listElement.children();
    	    var pager = $('.pager');
    	    
    	    if (typeof settings.childSelector!="undefined") {
    	        children = listElement.find(settings.childSelector);
    	    }
    	    
    	    if (typeof settings.pagerSelector!="undefined") {
    	        pager = $(settings.pagerSelector);
    	    }
    	    
    	    var numItems = children.size();
    	    var numPages = Math.ceil(numItems/perPage);

    	    pager.data("curr",0);
    	    
    	    if (settings.showPrevNext){
    	        $('<li><a href="#" class="prev_link">«</a></li>').appendTo(pager);
    	    }
    	    
    	    var curr = 0;
    	    while(numPages > curr && (settings.hidePageNumbers==false)){
    	        $('<li><a href="#" class="page_link">'+(curr+1)+'</a></li>').appendTo(pager);
    	        curr++;
    	    }
    	    $('<li class="current"><a>Displaying <span id="itemcount">'+perPage+'</span> of <span>'+numItems+'</span></a></li>').appendTo(pager);
    	    if (settings.showPrevNext){
    	        $('<li><a href="#" class="next_link">»</a></li>').appendTo(pager);
    	    }
    	    
    	    pager.find('.page_link:first').addClass('active');
    	    pager.find('.prev_link').hide();
    	    if (numPages<=1) {
    	        pager.find('.next_link').hide();
    	    }
    	  	pager.children().eq(1).addClass("active");
    	    
    	    children.hide();
    	    children.slice(0, perPage).show();
    	    
    	    pager.find('li .page_link').click(function(){
    	        var clickedPage = $(this).html().valueOf()-1;
    	        goTo(clickedPage,perPage);
    	        return false;
    	    });
    	    pager.find('li .prev_link').click(function(){
    	        previous();
    	        return false;
    	    });
    	    pager.find('li .next_link').click(function(){
    	        next();
    	        return false;
    	    });
    	    
    	    function previous(){
    	        var goToPage = parseInt(pager.data("curr")) - 1;
    	        if(numItems > (goToPage+1)*perPage){
    	        	$("#itemcount").text((goToPage+1)*perPage);
    	        }else{
    	        	$("#itemcount").text(numItems);
    	        }
    	        goTo(goToPage);
    	    }
    	    function next(){
    	        goToPage = parseInt(pager.data("curr")) + 1;
    	        if(numItems > (goToPage+1)*perPage){
    	        	$("#itemcount").text((goToPage+1)*perPage);
    	        }else{
    	        	$("#itemcount").text(numItems);
    	        }
    	        goTo(goToPage);
    	    }
    	    function goTo(page){
    	        var startAt = page * perPage,
    	            endOn = startAt + perPage;
    	        children.css('display','none').slice(startAt, endOn).show();
    	        if (page>=1) {
    	            pager.find('.prev_link').show();
    	        }
    	        else {
    	            pager.find('.prev_link').hide();
    	        }
    	        if (page<(numPages-1)) {
    	            pager.find('.next_link').show();
    	        }
    	        else {
    	            pager.find('.next_link').hide();
    	        }
    	        pager.data("curr",page);
    	      	pager.children().removeClass("active");
    	        pager.children().eq(page+1).addClass("active");
    	    }
    	};
	</script>
	</body>
</html>
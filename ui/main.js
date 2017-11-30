$(function(){

	/*var cellID = 1
	var floorID
	for (var i = 0; i < floorCount; i++) {
		$('.cells .columns').append('<div class="cell-column" id="floor-'+floorID+'"></div>')

		for (var k = 0; k < cellCountPerFloor; k++) {
			var thing = (Math.random() < 0.5 ? "open" : "")
			var text = "Open";
			if (thing != "open"){
				text = "Closed"
			}
			$('#floor-'+floorID).append(
				'<div class="cell '+thing+'" id="cell-'+cellID+'"> \
					<p>Cell '+cellID+'</p>				\
					<span>'+text+'</span> \
				</div>')
			cellID++;
		}

		floorID++;
	}*/


	$('.cell').click(function(){

		var id = $(this).attr('id');
		if ($(this).hasClass('open')){
			//close it

			$(this).removeClass('open')
			$(this).find('span:first').html('Closed')

		} else {
			//open it
			$(this).addClass('open')
			$(this).find('span:first').html('Open')
		}

		$.post('http://esx_jail/select', JSON.stringify({id}));

	});


	window.addEventListener('message', function(event){
		if (event.data.type == "showMenu"){
			var data = event.data.data
			populate(data);
			setTimeout(function(){
				$('.cells').fadeIn();
			}, 200)
		}
	});


	$(document).keyup(function(e){
		if (e.keyCode == 27){
			$('.cells').fadeOut();
			$.post('http://esx_jail/close');
		}
	})

});

function populate(data){
	$('.cells .columns').html('')
	var floorCount = 2;
	var cellCountPerFloor = 7;

	var cellID = 0
	var cellNumber = 1
	var floorID = 1

	for (var i = 0; i < floorCount; i++) {
		$('.cells .columns').append('<div class="cell-column" id="floor-'+floorID+'"></div>')
		cellNumber = 1;
		for (var k = 0; k < cellCountPerFloor; k++) {

			var thing = data[cellID].state
			var text = "Open";
			var css = "open";
			if (thing == true){
				text = "Closed"
				css = "";
			}
			$('#floor-'+floorID).append(
				'<div class="cell '+css+'" id="'+data[cellID].id+'"> \
					<p>Cell '+cellNumber+'</p>				\
					<span>'+text+'</span> \
				</div>')
			cellID++;
			cellNumber++;
		}

		floorID++;
	}

}
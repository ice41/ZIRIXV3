/*--------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da CidadePerdida, por favor mantenha os créditos   ]--
--[                     NPED.PT - DarkDEVs Discord: discord.gg/ZTPrPbtaTu                    ]--
--------------------------------------------------------------------------------------------------------*/
$(function(){
	init();

	var actionContainer = $("#actionmenu");

	window.addEventListener('message',function(event){
		var item = event.data;

		if (item.showmenu){
			ResetMenu()
			actionContainer.show();
		}

		if (item.hidemenu){
			actionContainer.hide();
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			if (actionContainer.is(":visible")){
				sendData("ButtonClick","fechar")
			}
		}
	};
})

function ResetMenu(){
	$("div").each(function(i,obj){
		var element = $(this);

		if (element.attr("data-parent")){
			element.hide();
		} else {
			element.show();
		}
	});
}

function init() {
	$(".menuoption").each(function(i,obj){

		if ($(this).attr("data-action")){
			$(this).click(function(){
				var data = $(this).data("action"); 
				sendData("ButtonClick",data); 
			})
		}

		if ($(this).attr("data-sub")){
			var menu = $(this).data("sub");
			var element = $("#"+menu);

			$(this).click(function(){
				element.show();
				$(this).parent().hide();
			})

			var backBtn = $('<button/>',{text:'Voltar'});

			backBtn.click(function(){
				element.hide();
				$("#"+element.data("parent")).show();
			});

			element.append(backBtn);
		}
	});
}

function sendData(name,data){
	$.post("http://oc_refinar-coca/"+name,JSON.stringify(data),function(datab){
		if (datab != "ok"){
			console.log(datab);
		}
	});
}
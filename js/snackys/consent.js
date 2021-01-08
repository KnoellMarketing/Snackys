function consentSave(value)
{
	if(!value)
		value = ($('#consentAccept').is(':checked')) ? 2 : 1;
	
	var date = new Date();
	date.setTime(date.getTime() + (365*24*60*60*1000));
	var expires = "; expires=" + date.toUTCString();
    document.cookie = "consentState=" + (value || 1)  + expires + "; path=/";
	
	$('#consentmanager').addClass('hidden');
	$('#consentmanager').removeClass('modal-dialog');
	$('#consentPicker').removeClass('hidden');
	window.dataLayer = window.dataLayer || [];
	window.dataLayer.push({consentState:value});
	window.dataLayer.push({'event':'consentGiven','consentState':value});
}

function consentSaveAll(){ $('#consentAccept').attr('checked','checked'); consentSave(2); }

function showConsent() {
	$('#consentmanager').removeClass('hidden');
	$('#consentPicker').addClass('hidden');
	$('#consentmanager').addClass('modal-dialog');
}

function consentText() {
	if($('#consentIntro').hasClass('hidden'))
	{
		$('#consentIntro').removeClass('hidden');
		$('#consentDetail').addClass('hidden');
	} else {
		$('#consentIntro').addClass('hidden');
		$('#consentDetail').removeClass('hidden');
	}
}

//Jetzt Trigger setzen
$('#consentText').on('click',function(){ consentText() });
$('#consentPicker').on('click',function(){ showConsent() });
$('#consentSave').on('click',function(){ consentSave() });
$('#consentAll').on('click',function(){ consentSaveAll() });

//Check if neede to send to dataLayer onload
if($('#consentmanager').hasClass('hidden'))
{
	var value = ($('#consentAccept').is(':checked')) ? 2 : 1;
	window.dataLayer = window.dataLayer || [];
	window.dataLayer.push({consentState:value});
	window.dataLayer.push({'event':'consentGiven','consentState':value});
} 
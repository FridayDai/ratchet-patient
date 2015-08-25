<script>
	function detectmob() {
		if( navigator.userAgent.match(/Android/i)
				|| navigator.userAgent.match(/webOS/i)
				|| navigator.userAgent.match(/iPhone/i)
				|| navigator.userAgent.match(/iPad/i)
				|| navigator.userAgent.match(/iPod/i)
				|| navigator.userAgent.match(/BlackBerry/i)
				|| navigator.userAgent.match(/Windows Phone/i)
		){
			return true;
		}
		else {
			return false;
		}
	}

	if (!detectmob()) {
		var css =
				".rc-radio:hover:before {" +
					"position: absolute;" +
					"top: 2px;" +
					"left: 2px;" +
					"display: block;" +
					"width: 36px;" +
					"height: 36px;" +
					"border-radius: 50%;" +
					"content: '';" +
				"}" +
				"@media only screen and (max-width: 767px) {" +
					".rc-radio:hover:before {" +
						"width: 20px;" +
						"height: 20px;" +
					"}" +
				"}" +
				"@media only screen and (min-width: 768px) {" +
					".nrs .rc-radio:hover:before {" +
						"position: static;" +
						"width: 40px;" +
						"height: 40px;" +
						"color: #fff;" +
					"}" +
				"}" +
				".rc-radio:hover:before {" +
					"background-color: ${client.primaryColorHex?:'#0f137d'} !important;"  +
				"}";

		var head = document.head || document.getElementsByTagName('head')[0];
		var style = document.createElement('style');

		style.type = 'text/css';
		if (style.styleSheet){
			style.styleSheet.cssText = css;
		} else {
			style.appendChild(document.createTextNode(css));
		}

		head.appendChild(style);
	}
</script>

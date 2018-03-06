# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(".clickable p").on "click", (e) ->
		s = window.getSelection();
		range = s.getRangeAt(0);
		node = s.anchorNode;
		space = range.toString().indexOf(' ');
		flag = false;
		while (space != 0)
			startOffset = range.startOffset;
			if (startOffset < 1)
				flag = true;
				break;
			range.setStart(node, (range.startOffset - 1));
			space = range.toString().indexOf(' ');
		if (flag)
			range.setStart(node, 0);
			if (range.commonAncestorContainer.data.indexOf(" ") == -1)
				stupidVariable = range.commonAncestorContainer.data.length;
				range.setEnd(node, ((stupidVariable)));
			else
				range.setEnd(node, range.commonAncestorContainer.data.indexOf(" "));
		else
			range.setStart(node, range.startOffset + 1);
			range.setEnd(node, range.endOffset + 1);
			while (range.toString().indexOf(' ') == -1 && range.toString().trim() != '' && range.endOffset < node.length)
				range.setEnd(node, range.endOffset + 1);
		
		word = range.commonAncestorContainer.data;
		str = range.toString().trim();
		locationOfWord = e.target.innerHTML.lastIndexOf(word);
		before = e.target.innerHTML.substr(0, locationOfWord);
		after = e.target.innerHTML.substr(locationOfWord + word.length);
		e.currentTarget.className = "underliner whatWeJustDid";
		if (e.currentTarget.innerHTML.search("<mark>" + str + "</mark>") == -1)
			if range.endOffset = word.length
				e.target.innerHTML = before + word.substr(0, range.startOffset)+ "<mark>" + str + "</mark>" + word.substr(range.endOffset) + after;
			else
				e.target.innerHTML = before + word.substr(0, range.startOffset)+ "<mark>" + str + "</mark>" + word.substr(range.endOffset - 1) + after;
		$("#Cueinput").modal("toggle");

	$("#submit").on "click", (e) ->
		$("#Cueinput").modal("toggle");
		alert("be alert, the world needs more lerts" + " " + $("#CueType").val() + " " + $("#CueLabel").val() + " " + $("#CueDescription").val());
		$(".whatWeJustDid")[0].innerHTML = $(".whatWeJustDid")[0].innerHTML + "<p class=\"cues\">" +  $("#CueType").val() + " " + $("#CueLabel").val() + " " + $("#CueDescription").val() + "</p>";
		console.log($(".whatWeJustDid")[0]);
		$(".whatWeJustDid")[0].className = "underliner";









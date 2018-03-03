# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(".clickable p").on "click", (e) ->
		s = window.getSelection();
		range = s.getRangeAt(0);
		console.log(e);
		console.log(range);
		console.log(range.toString());
		node = s.anchorNode;
		space = range.toString().indexOf(' ');
		console.log(range.startOffset);
		flag = false;
		while (space != 0)
			startOffset = range.startOffset;
			console.log(startOffset);
			if (startOffset < 1)
				flag = true;
				break;
			range.setStart(node, (range.startOffset - 1));
			space = range.toString().indexOf(' ');
		if (flag)
			range.setStart(node, 0);
			range.setEnd(node, range.commonAncestorContainer.data.indexOf(" "));
		else
			range.setStart(node, range.startOffset + 1);
			range.setEnd(node, range.endOffset + 1);
			while (range.toString().indexOf(' ') == -1 && range.toString().trim() != '' && range.endOffset < node.length)
				range.setEnd(node, range.endOffset + 1);
		
		console.log(range);
		console.log(range.commonAncestorContainer.data);
		word = range.commonAncestorContainer.data;
		str = range.toString().trim();
		console.log(word);
		console.log(e.target.innerHTML.lastIndexOf(word));
		locationOfWord = e.target.innerHTML.lastIndexOf(word);
		before = e.target.innerHTML.substr(0, locationOfWord);
		after = e.target.innerHTML.substr(locationOfWord + word.length);
		console.log(e.target.innerHTML);
		console.log(e.target.innerHTML.lastIndexOf(">"));
		console.log(word.substr(0, range.startOffset)+ "<mark>" + str + "</mark>" + word.substr(range.endOffset - 1));
		if range.endOffset = word.length
			e.target.innerHTML = before + word.substr(0, range.startOffset)+ "<mark>" + str + "</mark>" + word.substr(range.endOffset) + after;
		else
			e.target.innerHTML = before + word.substr(0, range.startOffset)+ "<mark>" + str + "</mark>" + word.substr(range.endOffset - 1) + after;


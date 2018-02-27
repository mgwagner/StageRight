# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(".clickable p").on "click", (e) ->
		s = window.getSelection();
		range = s.getRangeAt(0);
		node = s.anchorNode;
		space = range.toString().indexOf(' ');
		while (space != 0)
			range.setStart(node, (range.startOffset - 1));
			space = range.toString().indexOf(' ');
		range.setStart(node, range.startOffset + 1);
		range.setEnd(node, range.endOffset + 1);
		while (range.toString().indexOf(' ') == -1 && range.toString().trim() != '' && range.endOffset < node.length)
			range.setEnd(node, range.endOffset + 1);
		
		str = range.toString().trim();
		alert(str);
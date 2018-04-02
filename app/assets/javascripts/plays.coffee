# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org
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

		if (e.currentTarget.innerHTML.search("<mark>" + str + "</mark>") == -1)
			if range.endOffset = word.length
				window.storingThing1 = e.target;
				window.storingThing2 = before + word.substr(0, range.startOffset)+ "<mark>" + str + "</mark>" + word.substr(range.endOffset) + after;
			else
				window.storingThing1  = e.target;
				window.storingThing2 = before + word.substr(0, range.startOffset)+ "<mark>" + str + "</mark>" + word.substr(range.endOffset - 1) + after;

		for i in [0...e.target.parentElement.children.length]
			if e.target.parentElement.children[i] == e.target
				window.CueLineNum = i;
		
		window.Cuelocation = range.startOffset;

		$("#cueForm")[0].innerHTML = '<h4>Cue #' + 1 + '</h4><div class="form-group">
		        <label for="CueType">Cue Type</label>
		        <input type="text" class="form-control" id="CueType' + (1) + '" placeholder="e.g. LQ, SQ, etc...">
		    </div>
		    <div class="form-group">
		        <label for="CueLabel">Cue Label</label>
		        <input type="text" class="form-control" id="CueLabel' + (1) + '" placeholder="e.g. 100, A, etc...">
		    </div>
		    <div class="form-group">
		        <label for="CueDescription">Cue Description</label>
		        <input type="text" class="form-control" id="CueDescription' + (1) + '" placeholder="optional">
		    </div>';
		$("#cueNumber").val(1);
		$("#Cueinput").modal("toggle");

	$("#submit").on "click", (e) ->
		$("#Cueinput").modal("toggle");
		cueNumber = parseInt($("#cueNumber").val());
		newString = window.storingThing2;
		cueTypeArray = [];
		cueLabelArray = [];
		cueDescriptionArray = [];
		for i in [1...cueNumber + 1]
			newString += "<p class=\"cues\"> " +  $("#CueType" + (cueNumber + 1 - i)).val() + " " + $("#CueLabel" + (cueNumber + 1 - i)).val() + " " + "</p>";
			cueTypeArray.push($("#CueType" + (cueNumber + 1 - i)).val());
			cueLabelArray.push($("#CueLabel" + (cueNumber + 1 - i)).val())
			cueDescriptionArray.push($("#CueDescription" + (cueNumber + 1 - i)).val());
		window.storingThing1.innerHTML = window.storingThing2;
		window.storingThing1.innerHTML = newString;
		console.log($(".whatWeJustDid"));
		console.log(newString);
		window.storingThing1.className = "underliner";

		$.post '/plays/cuesDB',
			cueType: cueTypeArray
			cueLabel: cueLabelArray
			cueDescription: cueDescriptionArray
			location: window.Cuelocation
			cueLineNum: window.CueLineNum
			(data) -> console.log(data)


	$("#addCue").on "click", (e) ->
		cueNumber = parseInt($("#cueNumber").val());
		$("#cueNumber").val(cueNumber + 1);
		cueTypes = [];
		cueLabels = [];
		cueDescriptions = [];
		for i in [1...cueNumber + 1]
			cueTypes.push($("#CueType" + i).val());
			cueLabels.push($("#CueLabel" + i).val());
			cueDescriptions.push($("#CueDescription" + i).val());
		$("#cueForm")[0].innerHTML = $("#cueForm")[0].innerHTML + '<div class="form-break"> </div> <h4>Cue #' + $("#cueNumber").val() + '</h4><div class="form-group">
                <label for="CueType">Cue Type</label>
                <input type="text" class="form-control" id="CueType' + (cueNumber + 1) + '" placeholder="e.g. LQ, SQ, etc...">
            </div>
            <div class="form-group">
                <label for="CueLabel">Cue Label</label>
                <input type="text" class="form-control" id="CueLabel' + (cueNumber + 1) + '" placeholder="e.g. 100, A, etc...">
            </div>
            <div class="form-group">
                <label for="CueDescription">Cue Description</label>
                <input type="text" class="form-control" id="CueDescription' + (cueNumber + 1) + '" placeholder="optional">
            </div>';
		for i in [1...cueNumber+1]
			$("#CueType" + i).val(cueTypes[i-1]);
			$("#CueLabel" + i).val(cueLabels[i-1]);
			$("#CueDescription" + i).val(cueDescriptions[i-1]);








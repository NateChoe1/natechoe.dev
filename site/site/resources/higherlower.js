/*
@licstart  The following is the entire license notice for the 
JavaScript code in this page.

This code copyright (C) 2022  Nate Choe

The JavaScript code in this page is free software: you can
redistribute it and/or modify it under the terms of the GNU
General Public License (GNU GPL) as published by the Free Software
Foundation, either version 3 of the License, or (at your option)
any later version.  The code is distributed WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU GPL for more details.

As additional permission under GNU GPL version 3 section 7, you
may distribute non-source (e.g., minimized or compacted) forms of
that code without the copy of the GNU GPL normally required by
section 4, provided you include this license notice and a URL
through which recipients can access the Corresponding Source.   


@licend  The above is the entire license notice
for the JavaScript code in this page.
 * */

let toremove = document.getElementsByClassName("noscript");
for (element of toremove) {
	element.remove();
}

let higherlowergame = document.getElementById("higherlowergame");

let input = document.createElement("input");
input.type = "text";
higherlowergame.appendChild(input);
let btn = document.createElement("button");
btn.innerHTML = "Guess";
higherlowergame.appendChild(btn);

let feedbackmsg = document.createElement("p");

let answer = Math.floor(Math.random() * 1000) + 1;

function feedback() {
	if (input.value == "lower" || input.value == "higher")
		feedbackmsg.innerHTML = "ha ha very funny";
	else if (isNaN(input.value) || input.value < 1 || input.value > 1000)
		feedbackmsg.innerHTML = "Please enter a number between 1 and 1000";
	else if (input.value < answer)
		feedbackmsg.innerHTML = "The number is higher";
	else if (input.value > answer)
		feedbackmsg.innerHTML = "The number is lower";
	else if (input.value == answer)
		feedbackmsg.innerHTML = "You got it!";
	higherlowergame.appendChild(feedbackmsg);
}

btn.onclick = feedback;
input.onkeypress = function(e) {
	if (!e) e = window.event;
	var keycode = e.code || e.key;
	if (keycode == "Enter")
		feedback();
}

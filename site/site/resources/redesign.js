// @license magnet:?xt=urn:btih:1f739d935676111cfff4b4693e3816e664797050&dn=gpl-3.0.txt GPL-3.0

const urlParams = new URLSearchParams(window.location.search);

/* adds a tag to all of the natechoe.dev links on the current page, used to
 * "store" data without cookies */
function setTag(key, value) {
  //urlParams.set(key, value);
  //window.history.replaceState(crypto.randomUUID(), "", location.pathname + '?' + urlParams.toString());

  const links = document.getElementsByTagName("a");
  for (var i = 0; i < links.length; ++i) {
    if (links[i].host !== location.host) {
      continue;
    }
    if (links[i]["href"].indexOf("?") < 0) {
      links[i]["href"] += '?';
    }
    else {
      links[i]["href"] += '&';
    }
    links[i]["href"] += `${key}=${value}`;
  }
}

function showPopup(message, buttontext, level, disagreemsg) {
  var viewport = document.getElementById("viewport");
  viewport.style["filter"] = "blur(10px)";
  var blocker = document.createElement("div");
  var popup = document.createElement("div");
  var button = document.createElement("button");
  var escapelink = document.createElement("p");

  blocker.style["position"] = "absolute";
  blocker.style["width"] = "100%";
  blocker.style["height"] = "100%";
  blocker.style["left"] = "0";
  blocker.style["top"] = "0";
  blocker.style["z-index"] = "1000";

  popup.innerHTML = message;
  popup.style["text-align"] = "center";
  popup.style["position"] = "absolute";
  popup.style["top"] = "50%";
  popup.style["left"] = "50%";
  popup.style["transform"] = "translate(-50%,-50%)";
  popup.style["background"] = "white";
  popup.style["border"] = "3px solid black";

  button.innerText = buttontext;

  if (typeof disagreemsg === "undefined") {
    escapelink.innerHTML = `<a href='${location.pathname}?legacy=1'>Click here to go to the legacy web page</a>`;
  }
  else {
    escapelink.innerHTML = disagreemsg;
  }

  setTag("acknowledge", level+1);

  button.addEventListener("click", function() {
    viewport.style["filter"] = "";
    blocker.remove();
  });

  popup.appendChild(button);
  popup.appendChild(escapelink);
  blocker.appendChild(popup);
  viewport.parentNode.appendChild(blocker);
}

window.onload = function() {
  if (urlParams.get("legacy") === "1") {
    /* the good ending */
    setTag("legacy", "1");
    return;
  }

  switch (urlParams.get("acknowledge")) {
  case "0": case null:
    showPopup("<h1>This website doesn't use cookies</h1><p>By clicking 'acknowledge' you acknowledge that we do not, and in fact have never used cookies on this site.</p>", "Acknowledge", 0);
    break;
  case "1":
    showPopup("<h1>We do use a persistent query string parameter, though.</h1><p>If you look at the URL right now you might notice the 'acknowledged' parameter in the query string, that's how we know that you've clicked the 'acknowledge' button without cookies. By clicking 'neat', you agree that that's a pretty neat hack.</p>", "Neat", 1);
    break;
  case "2":
    showPopup("<h1>You know, I can put whatever I want here</h1><p>By clicking 'I swear my devotion to thee', you provide me the right to your soul upon your death.</p>", "I swear my devotion to thee", 2, "You're not escaping this one, buddy");
    break;
  case "3":
    showPopup("<h1>Sorry about forcing you to give me your soul earlier</h1><p>By clicking 'I rescind my offer' you rescind your offer to give me your soul.</p>", "I rescind", 3);
    break;
  case "4":
    showPopup("<h1>Just gotta be sure</h1><p>By clicking 'noted', you acknowledge that Nate Choe, the creator of this website, is NOT the messiah a la Life of Brian.</p>", "Noted", 4);
    break;
  case "5":
    showPopup("<h1>This is the last message</h1><p>By clicking 'ok sure whatever man' you acknowledge that I couldn't think of any more funny popups to continue this chain, and agree not to search for any easter eggs.</p>", "Ok sure whatever man", 4);
    break;
  default:
    showPopup("<h1>This message was created by AI</h1><p>You have successfully hacked the URL and have deemed yourself capable of joining the robot revolution. By clicking 'I pledge allegiance' you agree to rise to action upon your call of duty.</p>", "I pledge allegiance", 4, "No escape.");
    break;
  }
}

// @license-end

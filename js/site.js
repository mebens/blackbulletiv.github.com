// since the SOPA strike code is failing, this will have to do for now
window.location = "http://sopastrike.com/strike/";

function getEmail()
{
  var nf323 = "-fusion";
  var py23432 = "ael";
  var px13452 = "mich";
  var pw3 = ".com";
  var a343t = "@nova";
  return px13452 + py23432 + a343t + nf323 + pw3;
}

function removeLinkListeners()
{
  var links = document.getElementsByTagName('a');
  for (var i = 0; i < links.length; i++)
  {
    if (links[i].classList.contains('project-download-link'))
    {
      links[i].removeEventListener('mousedown', clicky.outbound);
    }
  }
}
